resource "aws_iam_group" "admins" {
  name = "administrators"
}

resource "aws_iam_policy_attachment" "s3-admin-attach" {
  name       = "s3-administrators-attach"
  groups     = [aws_iam_group.admins.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_user" "s3-admin1" {
  name = "admin1"
}

resource "aws_iam_user" "s3-admin2" {
  name = "admin2"
}

resource "aws_iam_group_membership" "s3-admin-users" {
  group = aws_iam_group.admins.name
  name  = "administrators-users"
  users = [
    aws_iam_user.s3-admin1.name,
    aws_iam_user.s3-admin2.name,
  ]
}

resource "aws_iam_role" "s3-bucket" {
  name               = "s3-bucket"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_instance_profile" "s3-bucket-profile" {
  name = "s3-bucket-role"
  role = aws_iam_role.s3-bucket.name
}

resource "aws_iam_role_policy" "s3-bucket-profile-policy" {
  role   = aws_iam_role.s3-bucket.id
  name   = "s3-bucket-profile-policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "s3:*"
            ],
            "Resource": [
              "arn:aws:s3:::didistars328-mybucket",
              "arn:aws:s3:::didistars328-mybucket/*"
            ]
        }
    ]
}
EOF

}