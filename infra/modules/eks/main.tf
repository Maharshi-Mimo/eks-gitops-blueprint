module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  version                         = "~> 20.0"
  cluster_name                    = var.cluster_name
  cluster_version                 = var.cluster_version
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.subnet_ids
  enable_irsa                     = true
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  eks_managed_node_groups = {
    default = {
      instance_type = var.eks_node_group_instance_type
      desired_size  = var.eks_node_group_desired_size
      max_size      = var.eks_node_group_max_size
      min_size      = var.eks_node_group_min_size
      ami_type      = var.eks_node_group_ami_type
    }
  }
  cluster_addons = {
    vpc_cni            = { most_recent = true }
    coredns            = { most_recent = true }
    kube_proxy         = { most_recent = true }
    aws_ebs_csi_driver = { most_recent = true }
  }
}