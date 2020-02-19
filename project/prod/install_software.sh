#!/bin/bash

amazon-linux-extras install docker
service docker start
usermod -a -G docker ec2-user
amazon-linux-extras install nginx1.12
echo "This AMI was generated at date $(date +%m-%d-%Y)" > /root/ami_gen_file.txt

