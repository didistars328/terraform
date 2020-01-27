resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

  # sample file provision
  provisioner "file" {
    source = "sample.sh"
    destination = "/tmp/sample.sh"
  }

  # edit file permissions and execute
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/sample.sh",
      "sudo /tmp/sample.sh",
    ]
  }

  # run local terminal command and redirect to a file
  provisioner "local-exec" {
    command = <<EOT
    echo ${aws_instance.example.private_ip}  > local_action.txt
    echo ${aws_instance.example.private_dns} >> local_action.txt
    EOT
  }

  # to connect to your instance U Must haven these settings
  connection {
    host = coalesce(self.public_ip, self.private_ip)
    type = "ssh"
    user = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}

