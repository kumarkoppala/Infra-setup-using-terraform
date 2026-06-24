resource "aws_route53_record" "r53" {
  for_each = aws_instance.roboshop
  zone_id  = var.zone_id
  name     = "${each.key}.yokshithkumar.shop"
  type     = "A"
  ttl      = "1"
  records  = [each.value.private_ip]
}

resource "aws_route53_record" "r53-lb" {
  count   = contains(keys(var.instances), "lb") ? 1 : 0
  zone_id = var.zone_id
  name    = "yokshithkumar.shop"
  type    = "A"
  ttl     = "1"
  records = [lookup(aws_instance.roboshop, "lb").public_ip]
}

