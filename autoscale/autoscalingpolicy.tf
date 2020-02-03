resource "aws_autoscaling_policy" "example-cpu-policy" {
  autoscaling_group_name = aws_autoscaling_group.example-autoscaling.name
  name = "example-cpu-policy"
  scaling_adjustment = "2"
  adjustment_type = "ChangeInCapacity"
  cooldown = "300"
  policy_type = "SimpleScaling"    # default value - can be omitted
}

resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm" {
  alarm_name = "example-cpu-alarm"
  alarm_description = "example-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.example-autoscaling.name
  }

  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.example-cpu-policy.arn]
}

resource "aws_autoscaling_policy" "example-cpu-scaledown" {
  autoscaling_group_name = aws_autoscaling_group.example-autoscaling.name
  name = "example-cpu-scaledown"
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "-1"
  cooldown = "300"
  policy_type = "SimpleScaling"       # default value - can be omitted
}

resource "aws_cloudwatch_metric_alarm" "example-cpu-scaledown" {
  alarm_name = "example-cpu-scaledown"
  alarm_description = "example-cpu-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "5"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.example-autoscaling.name
  }

  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.example-cpu-scaledown.arn]
}