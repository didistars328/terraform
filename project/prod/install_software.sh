#!/bin/bash

amazon-linux-extras install docker
service docker start
usermod -a -G docker ec2-user
amazon-linux-extras install nginx1.12
service nginx start
echo "Testing custom hooks 2" > /tmp/hooks