variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
}

variable "vpc_azs" {
    description = "Availability zone for the vpcs"
    type = list(string)
}

variable "vpc_private_subnets" {
    description = "CIDR blocks for the private subnets"
    type = list(string)
}

variable "vpc_public_subnets" {
    description = "CIDR blocks for the public subnets"
    type = list(string)
}

variable "vpc_enable_nat_gateway" {
    description = "Whether to enable NAT Gateway for the VPC"
    type = bool
}

variable "vpc_enable_dns_hostnames" {
    description = "Whether to enable DNS hostnames for the VPC"
    type = bool
}

variable "vpc_name" {
    description = "Name of the VPC"
    type = string
}

variable "cluster_name" { 
    description = "Name of the EKS cluster"
    type = string
}
