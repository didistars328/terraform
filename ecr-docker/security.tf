resource "aws_security_group" "lb_security_group" {
  name = "load_balancer"
  description = "Security Group for Load Balancer"
  vpc_id = aws_vpc.main.id
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "LB_APP"
  }
}


resource "aws_security_group" "ecs_security_group" {
  name = "ecs"
  description = "security group for ecs"
  vpc_id = aws_vpc.main.id
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 3000
    protocol = "tcp"
    to_port = 3000
    security_groups = [aws_security_group.lb_security_group.id]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ECS"
  }
}