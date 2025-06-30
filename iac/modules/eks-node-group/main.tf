resource "aws_eks_node_group" "eks-defaults-nodes" {
  cluster_name    = var.cluster-name
  node_group_name = var.node-group-name
  node_role_arn   = var.node_role_arn   
  subnet_ids      = var.cluster-subnet-ids

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.small"]
  capacity_type = "SPOT"
}