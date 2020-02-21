# 1. Add app teplate and task
data "template_file" "docker-app-template" {
  template = file("app.json.tpl")
  vars = {
    REPOSITORY_URL = replace(aws_ecr_repository.docker-app.repository_url, "https://", "")
  }
}

resource "aws_ecs_task_definition" "docker-app-definition" {
  container_definitions = data.template_file.docker-app-template.rendered
  family = "docker-app"
}

# 2. Add Load Balancer
resource "aws_elb" "docker-app-elb" {
  listener {
    instance_port = 3000
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 3
    interval = 60
    target = "HTTP:3000/"
    timeout = 30
    unhealthy_threshold = 3
  }

  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  subnets = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  security_groups = [aws_security_group.lb_security_group.id]

  tags = {
    Name = "Docker-app-elb"
  }
}

# 3. Add ECS Service
resource "aws_ecs_service" "docker-app-service" {
  name = "docker_app_service"
  cluster = aws_ecs_cluster.cluster-ecs-app.id
  task_definition = aws_ecs_task_definition.docker-app-definition.arn
  desired_count = 1
  iam_role = aws_iam_role.ecs_service_role.arn
  depends_on = [aws_iam_policy_attachment.ecs_service_attachment]

  load_balancer {
    elb_name = aws_elb.docker-app-elb.name
    container_name = "docker-app-elb"
    container_port = 3000
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}