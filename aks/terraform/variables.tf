################################################################################
# Base variables
################################################################################
variable "project_name" {
  description = "Project main name"
  type        = string
  default     = "AKS-cloud-setup"
}

variable "tags_base" {
  description = "A map of the basic tags"
  type        = map(string)
  default = {
    Terraform = "true"
  }
}


variable "subscription_id" {
  description = "The subscription ID where the resources are created"
  type        = string
  default     = "2bcfe589-26cd-455a-bdd4-b8975088c52f"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "aks-rg"
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "East US"
}
################################################################################
# VNET variables
################################################################################
variable "vnet_space" {
  description = "Vnet address space"
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "aks_subnet" {
  description = "Aks address space"
  type        = list(string)
  default     = ["10.1.1.0/24"]
}

variable "appgw_subnet" {
  description = "Application gateway subnet"
  type        = list(string)
  default     = ["10.1.2.0/24"]
}
################################################################################
# AKS variables
################################################################################
variable "aks_dns_prefix" {
  description = "DNS prefix"
  type        = string
  default     = "cloud-setup-demo"
}

################################################################################
# Appgw variables
################################################################################
variable "appgw_frontend_port" {
  description = "Incoming traffic port"
  type        = number
  default     = 80
}

variable "appgw_backend_port" {
  description = "Backend for handling traffic from frontend"
  type        = number
  default     = 80
}

variable "appgw_backend_timeout" {
  description = "Timeout for requests"
  type        = number
  default     = 10
}
