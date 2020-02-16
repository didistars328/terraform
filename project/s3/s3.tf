resource "aws_s3_bucket" "didistars328" {
  bucket = "${var.S3_BUCKET}"
  acl    = "private"
  force_destroy = true

  tags = {
    Name = "didistars328-mybucket"
  }
}