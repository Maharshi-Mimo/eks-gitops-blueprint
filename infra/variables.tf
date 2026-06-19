variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}
    
variable "aws_profile" {
  description = "AWS CLI profile"
  type        = string
  default     = "default"
}

variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "my-eks-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.27"
}

variable "cluster_endpoint_private_access" {
  description = "Whether to enable private access to the EKS cluster endpoint"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access" {
  description = "Whether to enable public access to the EKS cluster endpoint"
  type        = bool
  default     = true
}
variable "eks_node_group_instance_type" {
  description = "EC2 instance type for the EKS node group"
  type        = string
  default     = "t3.medium"
}

variable "eks_node_group_desired_size" {
  description = "Desired number of nodes in the EKS node group"
  type        = number
  default     = 2
}

variable "eks_node_group_max_size" {
  description = "Maximum number of nodes in the EKS node group"
  type        = number
  default     = 3
}

variable "eks_node_group_min_size" {
  description = "Minimum number of nodes in the EKS node group"
  type        = number
  default     = 1
}

variable "eks_node_group_ami_type" {
  description = "AMI type for the EKS node group"
  type        = string
  default     = "AL2_x86_64"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.1.0/22"
}

variable "vpc_azs" {
  description = "Availability zones for the VPC"
  type        = list(string)
}

variable "vpc_private_subnets" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
}

variable "vpc_public_subnets" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
}

variable "vpc_enable_nat_gateway" {
  description = "Whether to enable NAT Gateway for the VPC"
  type        = bool
  default     = true
}

variable "vpc_enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames for the VPC"
  type        = bool
  default     = true
}

