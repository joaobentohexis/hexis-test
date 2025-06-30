resource "aws_eks_cluster" "eks-cluster" {
  name    = var.cluster-name
  #cluster_version = var.cluster-version
  #vpc_id     = var.cluster-vpc
  #subnet_ids = var.cluster-sub-net
  #enable_irsa = true
  vpc_config {
    subnet_ids = var.cluster-subnet-ids
  }
  role_arn = var.role-arn
  version  = "1.31"
}

  #   eks_managed_node_groups = {
  #   default = {
  #     desired_size = 1
  #     max_size     = 2
  #     min_size     = 1

  #     instance_types = ["t2.micro"]
  #     capacity_type  = "SPOT"
  #   }
  # }