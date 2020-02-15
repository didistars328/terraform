variable "AWS_REGION" {default = "eu-central-1"}
variable "PORTS" {
  type = map(list(string))
  default = {
    22 = ["0.0.0.0/0"]
  }
}
variable "AMI_ID" {default = "ami-0a356304de580bab7"}
