# 1. Add app teplate and task
data "template_file" "app-task-definition-template" {
  template = file("app.json.tpl")
  vars = {
    REPOSITORY_URL = replace(var.REPOSITORY, "https://", "")
    APP_VERSION    = var.MYAPP_VERSION
    APP_NAME = var.REPO_NAME
  }
}

resource "aws_ecs_task_definition" "app-task-definition" {
  family                = var.REPO_NAME
  container_definitions = data.template_file.app-task-definition-template.rendered
}

# 2. Add Load Balancer
resource "aws_elb" "app-elb" {
  name = "${var.REPO_NAME}-elb"

  listener {
    instance_port     = 3000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 30
    target              = "HTTP:3000/"
    interval            = 60
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  subnets         = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  security_groups = [aws_security_group.elb-security-group.id]

  tags = {
    Name = "${var.REPO_NAME}-elb"
  }
}

# 3. Add ECS Service
resource "aws_ecs_service" "app-service" {
  count           = var.MYAPP_SERVICE_ENABLE
  name            = var.REPO_NAME
  cluster         = aws_ecs_cluster.cluster-ecs.id
  task_definition = aws_ecs_task_definition.app-task-definition.arn
  desired_count   = 1
  iam_role        = aws_iam_role.ecs-service-role.arn
  depends_on      = [aws_iam_policy_attachment.ecs-service-attachment]

  load_balancer {
    elb_name       = aws_elb.app-elb.name
    container_name = var.REPO_NAME
    container_port = 3000
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}