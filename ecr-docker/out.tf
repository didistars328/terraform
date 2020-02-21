output "docker-app-repository-URL" {
  value = aws_ecr_repository.docker-app.repository_url
}
 output "elb" {
   value = aws_elb.docker-app-elb.dns_name
 }