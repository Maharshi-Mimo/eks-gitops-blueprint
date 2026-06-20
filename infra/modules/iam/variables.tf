variable "ecr_pull_role_name" {
  description = "Name of the IAM role for ECR pull access"
  type        = string
}

variable "github_actions_role_name" {
  description = "Name of the IAM role for GitHub Actions"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the EKS OIDC provider for IRSA"
  type        = string
}