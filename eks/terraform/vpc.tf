locals {
  selected_az = slice(data.aws_availability_zones.available.names, 0, 2)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "${var.Name}-vpc"
  cidr = var.vpc_cidr_block

  azs             = local.selected_az
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = var.tags_base
}
