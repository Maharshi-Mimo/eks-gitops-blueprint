provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}

module "eks" {
  source                          = "./modules/eks"
  vpc_id                          = module.vpc.vpc_id
  subnet_ids                      = module.vpc.private_subnets
  cluster_name                    = var.cluster_name
  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  eks_node_group_instance_type    = var.eks_node_group_instance_type
  eks_node_group_desired_size     = var.eks_node_group_desired_size
  eks_node_group_max_size         = var.eks_node_group_max_size
  eks_node_group_min_size         = var.eks_node_group_min_size
  eks_node_group_ami_type         = var.eks_node_group_ami_type
}

module "vpc" {
  source                   = "./modules/vpc"
  cluster_name             = var.cluster_name
  vpc_name                 = var.vpc_name
  vpc_cidr                 = var.vpc_cidr
  vpc_azs                  = var.vpc_azs
  vpc_private_subnets      = var.vpc_private_subnets
  vpc_public_subnets       = var.vpc_public_subnets
  vpc_enable_nat_gateway   = var.vpc_enable_nat_gateway
  vpc_enable_dns_hostnames = var.vpc_enable_dns_hostnames
}

