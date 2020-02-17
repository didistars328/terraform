module "main-vpc" {
  source     = "../modules/vpc"
  ENV        = "prod"
  AWS_REGION = var.AWS_REGION
}

module "instances" {
  source         = "../modules/instances"
  ENV            = "prod"
  AMI            = var.AMI
  VPC_ID         = module.main-vpc.vpc_id
  PUBLIC_SUBNETS = module.main-vpc.public_subnets
  PORTS          = var.PORTS
  APP_INSTANCE_COUNT = var.APP_INSTANCE_COUNT
}