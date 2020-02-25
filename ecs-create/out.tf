output "docker-app-repository-URL" {
  value = var.REPOSITORY
}
output "elb" {
  value = aws_elb.app-elb.dns_name
}