variable "AWS_REGION" {
  default = "eu-central-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "ECS_AMIS" {
  type = map(string)
  default = {
    us-east-1    = "ami-062f7200baf2fa504"
    us-west-2    = "ami-04590e7389a6e577c"
    eu-central-1 = "ami-0bfdae54e0eda93f2"
  }
}

variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}

variable "ECS_INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}