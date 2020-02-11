variable "AWS_REGION" {
  default = "eu-central-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1    = "ami-062f7200baf2fa504"
    us-west-2    = "ami-04590e7389a6e577c"
    eu-central-1 = "ami-07cda0db070313c52"
  }
}

variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}

#variable "MARIADB_PASS" {
#}

### Only use with data aws_ami ###
variable "ENV" {
  default = "prod"
}

variable "tags_values" {
  type = map(string)
  default = {
    Component   = "Frontend"
    Environment = "Production"
  }
}

variable "ports" {
  type = map(list(string))
  default = {
    "22"  = ["127.0.0.1/32", "192.168.0.0/24"]
    "443" = ["0.0.0.0/0"]
  }
}