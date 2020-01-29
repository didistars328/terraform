data "template_file" "init_script" {
  template = file("cloud_init.cfg")
  vars = {
    REGION = var.AWS_REGION
  }
}

data "template_file" "shell-script" {
  template = file("volumes.sh")
  vars = {
    DEVICE = var.INSTANCE_DEVICE_NAME
    MOUNT_POINT = "/data"
  }
}

data "template_cloudinit_config" "cloud-init-simple" {
  gzip = false
  base64_encode = false

  part {
    filename = "cloud_init.cfg"
    content_type = "text/cloud-config"
    content = data.template_file.init_script.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.shell-script.rendered
  }
}