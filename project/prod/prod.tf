module "main-vpc" {
  source = "../modules/vpc"
  ENV = "prod"
}

module "instances" {
  source = "../modules/instances"
  ENV = "prod"
}