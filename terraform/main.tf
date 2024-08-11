locals {
  tags = {
    created-by = "eks-hilltop"
    env        = var.cluster_name
  }
}