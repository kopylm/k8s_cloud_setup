################################################################################
# Common
################################################################################
output "actual_az" {
  value = local.selected_az
}

################################################################################
# VPC
################################################################################
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnets
}

################################################################################
# EKS
################################################################################
output "eks_cluster_id" {
  description = "EKS cluster id"
  value       = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_version" {
  description = "EKS cluster version"
  value       = module.eks.cluster_version
}

output "eks_cluster_security_group_id" {
  description = "EKS cluster Security Group ID"
  value       = module.eks.cluster_security_group_id
}
