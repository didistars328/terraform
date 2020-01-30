# Go with aws_instance
resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # private ip - from vpc subnet
  private_ip = "10.0.1.4"

  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

  ### USE OR UNCOMMENT BELOW PROVISIONERS ###
  ### IF CLOUD-CONFIG IS NOT IN THIS LIST ###

  # sample file provision
  #provisioner "file" {
  #  source      = "sample.sh"
  #  destination = "/tmp/sample.sh"
  #}

  # edit file permissions and execute
  #provisioner "remote-exec" {
  #  inline = [
  #    "chmod +x /tmp/sample.sh",
  #    "sudo /tmp/sample.sh",
  #  ]
  #}

  # to connect to your instance U Must have these settings
  #connection {
  #  host        = coalesce(self.public_ip, self.private_ip)
  #  type        = "ssh"
  #  user        = var.INSTANCE_USERNAME
  #  private_key = file(var.PATH_TO_PRIVATE_KEY)
  #}

  # run local terminal command and redirect to a file
  provisioner "local-exec" {
    command = <<EOT
    echo ${aws_instance.example.private_ip}  > local_action.txt
    echo ${aws_instance.example.private_dns} >> local_action.txt
    EOT
  }

  # add cloud-config part
  user_data = data.template_cloudinit_config.cloud-init-simple.rendered

  # add TAG to your instance
  tags = {
    Name = "test-box"
  }
}

# Create Volume
resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "eu-central-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "extra volume data"
  }
}

# Attached volume
resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name  = var.INSTANCE_DEVICE_NAME
  volume_id    = aws_ebs_volume.ebs-volume-1.id
  instance_id  = aws_instance.example.id
  skip_destroy = true # skip destroy to avoid issues with terraform destroy
}