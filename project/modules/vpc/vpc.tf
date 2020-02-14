# 1. Specify VARS

variable "ENV" {}
variable "AWS_REGION" {}

# 2. Specify VPC

module "main-vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "2.24.0"
  name = "vpc-${var.ENV}"
  cidr = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  azs                  = ["${var.AWS_REGION}a", "${var.AWS_REGION}b", "${var.AWS_REGION}c"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = var.ENV
  }
}

# 3. Add Output values

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.main-vpc.vpc_id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.main-vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.main-vpc.public_subnets
}