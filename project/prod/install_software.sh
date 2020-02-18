#!/bin/bash

amazon-linux-extras install docker
service docker start
usermod -a -G docker ec2-user
amazon-linux-extras install nginx1.12
echo "This AMI was generated at $(date +%m-%d-%Y)" > /root/AMI_gen_file.txt

