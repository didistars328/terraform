# 1. Specify VARS

variable "ENV" {}
variable "INSTANCE_TYPE" {default = "t2.micro"}
variable "PATH_TO_PUBLIC_KEY" {default = "mykey.pub"}
variable "VPC_ID" {}
variable "PORTS" {}
variable "PUBLIC_SUBNETS" {type = list(string)}

# 2. Specify AMI

data "aws_ami" "amazon2" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["137112412989"]
}

# 3. Add security groups

resource "aws_security_group" "allow-ssh" {
  vpc_id = var.VPC_ID
  name = "allow-ssh-${var.ENV}"
  description = "Security group that allows SSH and ALL egress traffic"

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = var.PORTS
    content {
      from_port = ingress.key
      protocol = "tcp"
      to_port = ingress.key
      cidr_blocks = ingress.value
    }
  }
}

# 4. Specify piblic KEY

resource "aws_key_pair" "mykey-pub" {
  public_key = file("${path.root}/${var.PATH_TO_PUBLIC_KEY}")
  key_name = "mykey-${var.ENV}"
}

# 5. Describe AWS Instance
resource "aws_instance" "instance" {
  ami = data.aws_ami.amazon2.id
  instance_type = var.INSTANCE_TYPE
  subnet_id = element(var.PUBLIC_SUBNETS,0)
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  key_name = aws_key_pair.mykey-pub.key_name

  tags = {
    Name = "Instance-${var.ENV}"
    Environment = var.ENV
  }
}