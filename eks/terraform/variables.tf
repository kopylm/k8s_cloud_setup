################################################################################
# Base variables
################################################################################
variable "region" {
  description = "Application region"
  type        = string
  default     = "us-east-1"
}

variable "Name" {
  description = "Project main name"
  type        = string
  default     = "EKS-cloud-setup"
}

variable "tags_base" {
  description = "A map of the basic tags"
  type        = map(string)
  default = {
    Terraform = "true"
  }
}

################################################################################
# VPC variables
################################################################################
variable "vpc_cidr_block" {
  description = "VPC cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

################################################################################
# EKS variables
################################################################################
variable "eks_cluster_version" {
  description = "Cluster version"
  type        = string
  default     = "1.30"
}

variable "worker_group_ami_type" {
  type    = string
  default = "AL2023_x86_64_STANDARD"
}

variable "worker_group_instance_types" {
  description = "Workers instance types"
  type        = list(string)
  default     = ["t3.medium"]
}
