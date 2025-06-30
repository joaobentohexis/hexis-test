#cluster IAM
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
###
#nodes IAM
resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry_read_only" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
###


module vpc {
 source  = "../../modules/vpc"
 #vpc-name = var.vpc-name
}


module eks-cluster {
 source  = "../../modules/eks"
 cluster-version = var.cluster-version
 cluster-name = var.cluster-name
 cluster-vpc = module.vpc.vpc_id
 cluster-subnet-ids = module.vpc.public_subnet_ids
 role-arn   = aws_iam_role.eks_cluster_role.arn
 depends_on = [
  aws_iam_role_policy_attachment.eks_cluster_policy,
  ]
}

module eks-defaults-nodes {
 source  = "../../modules/eks-node-group"
 cluster-name = var.cluster-name
 node-group-name = var.node-group-name
 node_role_arn = aws_iam_role.eks_node_role.arn
 depends_on = [
  aws_iam_role_policy_attachment.eks_worker_node_policy,
  aws_iam_role_policy_attachment.eks_cni_policy,
  aws_iam_role_policy_attachment.ec2_container_registry_read_only,
  module.eks-cluster,
  ]
 cluster-subnet-ids = module.vpc.public_subnet_ids
}