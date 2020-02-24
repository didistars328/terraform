output "docker-app-repository-URL" {
  value = aws_ecr_repository.app.repository_url
}
output "elb" {
  value = aws_elb.app-elb.dns_name
}