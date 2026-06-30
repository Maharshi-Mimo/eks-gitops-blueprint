provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name, "--region", var.aws_region, "--profile", var.aws_profile, "--output", "json"]
    env = {
      AWS_PROFILE         = var.aws_profile
      AWS_SDK_LOAD_CONFIG = "1"
      AWS_DEFAULT_OUTPUT  = "json"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name, "--region", var.aws_region, "--profile", var.aws_profile, "--output", "json"]
      env = {
        AWS_PROFILE         = var.aws_profile
        AWS_SDK_LOAD_CONFIG = "1"
        AWS_DEFAULT_OUTPUT  = "json"
      }
    }
  }
}

module "eks" {
  source                          = "./modules/eks"
  vpc_id                          = module.vpc.vpc_id
  subnet_ids                      = module.vpc.private_subnets
  cluster_name                    = var.cluster_name
  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  access_entries = {
    sso_admin = {
      principal_arn = "arn:aws:iam::484087913619:role/aws-reserved/sso.amazonaws.com/ap-south-1/AWSReservedSSO_AWSAdministratorAccess_97e5038acb0a4c50"
      type = "STANDARD"
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = { type = "cluster" }
        }
      }
    }
  }
  eks_node_group_instance_type = var.eks_node_group_instance_type
  eks_node_group_desired_size  = var.eks_node_group_desired_size
  eks_node_group_max_size      = var.eks_node_group_max_size
  eks_node_group_min_size      = var.eks_node_group_min_size
  eks_node_group_ami_type      = var.eks_node_group_ami_type
  depends_on                   = [module.vpc]
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

module "ecr" {
  source              = "./modules/ecr"
  ecr_repository_name = var.ecr_repository_name
  depends_on          = [module.iam]
}

module "iam" {
  source                   = "./modules/iam"
  ecr_pull_role_name       = var.ecr_pull_role_name
  github_actions_role_name = var.github_actions_role_name
  oidc_provider_arn        = module.eks.oidc_provider_arn
  depends_on               = [module.eks]
}

module "argocd" {
  source         = "./modules/argocd"
  depends_on     = [module.eks]
  argocd_version = var.argocd_app_version
}

