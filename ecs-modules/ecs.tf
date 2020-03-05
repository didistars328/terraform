# 1. Add ECS cluster
resource "aws_ecs_cluster" "cluster-ecs" {
  name = "cluster-ecs"
}
# 2. Add config to ECS
resource "aws_launch_configuration" "ecs-launchconfig" {
  name_prefix          = "ecs-launchconfig"
  image_id             = var.ECS_AMIS[var.AWS_REGION]
  instance_type        = var.ECS_INSTANCE_TYPE
  key_name             = aws_key_pair.mykeypair.key_name
  iam_instance_profile = aws_iam_instance_profile.ecs-ec2-role.id
  security_groups      = [aws_security_group.ecs-security-group.id]
  user_data            = <<EOF
     #!/bin/bash
     echo 'ECS_CLUSTER=cluster-ecs' > /etc/ecs/ecs.config
     start ecs
     EOF
  lifecycle {
    create_before_destroy = true
  }
}

# 3. Add autoscaling group
resource "aws_autoscaling_group" "ecs-autoscaling" {
  name                 = "ecs-autoscaling"
  launch_configuration = aws_launch_configuration.ecs-launchconfig.name
  vpc_zone_identifier  = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  min_size             = 1
  max_size             = 1
  tag {
    key                 = "Name"
    value               = "ecs-ec2-container"
    propagate_at_launch = true
  }
}