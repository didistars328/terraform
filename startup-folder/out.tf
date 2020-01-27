output "ip" {
  value = aws_instance.example.public_ip
}

output "dns" {
  value = aws_instance.example.public_dns
}

output "subnet" {
  value = aws_instance.example.subnet_id
}