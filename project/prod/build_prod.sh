#!/bin/zsh
source ~/.zshrc
ARTIFACT=`packer build -machine-readable packer-example.json | awk -F, '$0 ~/artifact,0,id/ {print $6}'`
AMI_ID=`echo $ARTIFACT | cut -d ':' -f2`
sed -i 's/variable "AMI_ID".*/variable "AMI_ID" {default = "'${AMI_ID}'"}/g' var.tf
terraform init
terraform apply
