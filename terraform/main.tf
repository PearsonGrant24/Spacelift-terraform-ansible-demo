# terraform {
#   required_version = ">= 1.5.0"
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 6.18.0"
#     }
#   }
# }

# provider "aws" {
#   region = "us-east-1"
# }

variable "app_name" {
  type    = string
  default = "terraform-ansible"
}

# ---------------------
# VPC MODULE
# ---------------------
module "vpc" {
  source   = "./modules/vpc"
  app_name = var.app_name
}

# ---------------------
# SECURITY MODULE
# ---------------------
module "security" {
  source = "./modules/security"

  vpc_id = module.vpc.vpc_id

#   app_name = var.app_name
}

# ---------------------
# KEYPAIR MODULE
# ---------------------
module "keypair" {
  source   = "./modules/keypair"
  app_name = var.app_name
}

# ---------------------
# EC2 MODULE
# ---------------------
module "ec2" {
  source = "./modules/ec2"

  subnet_id          = module.vpc.public_subnet_id
  security_group_id  = module.security.security_group_id
  key_name           = module.keypair.key_name
  app_name           = var.app_name
}
