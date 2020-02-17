#!/bin/zsh
source ~/.zshrc
ARTIFACT=`packer build -machine-readable packer-example.json | awk -F, '$0 ~/artifact,0,id/ {print $6}'`
AMI_ID=`echo $ARTIFACT | cut -d ':' -f2`
echo 'variable "AMI" { default = "'${AMI_ID}'" }' > amivar.tf
terraform init
terraform apply
