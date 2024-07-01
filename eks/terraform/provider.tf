provider "aws" {
  profile = "mend-hiring"
  region  = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.56.0"
    }
  }

  backend "s3" {
    bucket = "cloud-setup-terraform-state"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}
