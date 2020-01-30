### TO CREATE HOSTING ZONE ###
### UNCOMMENT THIS SECTION ###

#resource "aws_route53_zone" "didistars328-freedom" {
#  name = "didistars328.tk"
#}
### ADD DNS PUBLIC NAMES ###
###  TO USE ELASTIC IPS  ###
###   INDICATE AWS_EIP   ###

#resource "aws_route53_record" "nginx-record" {
#  zone_id = aws_route53_zone.didistars328-freedom.zone_id
#  name    = "nginx.didistars328.tk"
#  type    = "A"
#  ttl     = "300"
#  records = ["${aws_eip.example.public_ip}"]
#}
#
#resource "aws_route53_record" "www-record" {
#  zone_id = aws_route53_zone.didistars328-freedom.zone_id
#  name    = "www.didistars328.tk"
#  type    = "A"
#  ttl     = "300"
#  records = ["${aws_eip.example.public_ip}"]
#}