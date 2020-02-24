# 1. Add ECS cluster
resource "aws_ecs_cluster" "cluster-ecs-app" {
  name = "cluster_ecs_app"
}
# 2. Add config to ECS
resource "aws_launch_configuration" "ecs-app-launchconfig" {
  image_id = var.ECS_AMIS[var.AWS_REGION]
  instance_type = var.ECS_INSTANCE_TYPE
  name_prefix = "ecs-launchconfig"
  key_name = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.ecs_security_group.id]
  user_data = <<EOF
     #!/bin/bash
     echo 'ECS_CLUSTER=cluster-ecs-app' > /etc/ecs/ecs.config
     start ecs
     EOF
  iam_instance_profile = aws_iam_instance_profile.ecs_ec2_role.id
  lifecycle {
    create_before_destroy = true
  }
}

# 3. Add autoscaling group
resource "aws_autoscaling_group" "ecs-app-autoscaling" {
  name = "ecs-app-autoscaling"
  launch_configuration = aws_launch_configuration.ecs-app-launchconfig.name
  vpc_zone_identifier = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  max_size = 1
  min_size = 1
  tag {
    key = "Name"
    propagate_at_launch = true
    value = "ecs-ec2-container"
  }
}