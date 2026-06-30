output "oidc_provider_arn" {
  value       = module.eks.oidc_provider_arn
  description = "The ARN of the OIDC provider for the EKS cluster."
}

output "cluster_certificate_authority_data" {
  value       = module.eks.cluster_certificate_authority_data
  description = "The base64-encoded certificate authority data for the EKS cluster."
}

output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "The endpoint for the EKS cluster."
}