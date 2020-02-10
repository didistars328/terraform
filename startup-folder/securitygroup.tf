resource "aws_security_group" "allow-example-dev" {
  vpc_id      = module.vpc-dev.vpc_id
  name        = "allow-example-dev"
  description = "security group that allows ssh, tcp and all egress traffic in dev env"
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  tags = {
    Name = "allow-ssh/tcp in dev"
  }
}

resource "aws_security_group" "allow-example-prod" {
  vpc_id      = module.vpc-prod.vpc_id
  name        = "allow-example-prod"
  description = "security group that allows ssh and all egress traffic in prod"
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh in prod"
  }
}
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