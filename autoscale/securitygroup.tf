resource "aws_security_group" "allow-example" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-ssh-tcp"
  description = "security group that allows ssh, tcp and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    protocol        = "tcp"
    to_port         = 80
    security_groups = [aws_security_group.lb-security.id]
  }
  tags = {
    Name = "allow-ssh-tcp"
  }
}

resource "aws_security_group" "lb-security" {
  vpc_id      = aws_vpc.main.id
  name        = "lb"
  description = "security group for load balancer"
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ELB"
  }
}
### ENABLE TO WORK WITH RDS ###
### RENAME  "rds.tf.rename" ###

#resource "aws_security_group" "allow_mariadb" {
#  vpc_id      = aws_vpc.main.id
#  name        = "allow-mariadb"
#  description = "allows connection to RDS"
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0#0"]
#  }
#
#  ingress {
#    from_port   = 3306
#    to_port     = 3306
#    protocol    = "tcp"
#    security_groups = [aws_security_group.allow-example.id]
#  }
#
#  tags = {
#    Name = "allow-mariadb"
#  }
#}

