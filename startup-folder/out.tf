output "ip" {
  value = aws_instance.example.public_ip
}

output "dns" {
  value = aws_instance.example.public_dns
}

output "subnet" {
  value = aws_instance.example.subnet_id
}

### OUTPUT FOR RDS ###

#output "rds" {
#  value = aws_db_instance.mariadb.endpoint
#}

### OUTPUT FOR ROUTE 53 ###

#output "ns-servers" {
#  value = aws_route53_zone.didistars328-freedom.name_servers
#}

### OUTPUT FOR ELASTIC IP ###

#output "eip-output" {
#  value = aws_eip.example.public_ip
#}