module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.15.0"

  cluster_name                             = "${var.Name}-cluster"
  cluster_version                          = var.eks_cluster_version
  enable_cluster_creator_admin_permissions = true
  create_cloudwatch_log_group              = false
  cluster_endpoint_public_access           = true


  cluster_addons = {
    coredns                = { most_recent = true }
    eks-pod-identity-agent = { most_recent = true }
    kube-proxy             = { most_recent = true }
    vpc-cni                = { most_recent = true }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    worker_group = {
      ami_type       = var.worker_group_ami_type
      instance_types = var.worker_group_instance_types

      min_size     = 1
      max_size     = 2
      desired_size = 2
    }
  }

  depends_on = [module.vpc]

  tags = var.tags_base
}
