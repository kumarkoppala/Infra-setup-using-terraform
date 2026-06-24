resource "aws_route53_record" "roboshop" {
  for_each = aws_instance.roboshop
  #count = length(var.instances)
  zone_id = var.zone_id
  #name    = "${var.instances[count.index]}.yokshithkumar.shop"
  name = "${each.key}.yokshithkumar.shop"
  type    = "A"
  ttl     = "1"
  #records = ["aws_instance.roboshop[count.index].private_ip"]
  records = [each.value.private_ip]
}

resource "aws_route53_record" "frontend" {
  #count = contains(var.instances, "frontend") ? 1 : 0
  count = contains(keys(var.instances), "frontend") ? 1 : 0
  zone_id = var.zone_id
  name    = "yokshithkumar.shop"
  type    = "A"
  ttl     = "1"
  #records = [aws_instance.roboshop[index(var.instances, "frontend")].public_ip]
  records = [lookup(aws_instance.roboshop, "frontend").public_ip]
}



/*locals {
  # 1. Your list of instance names
  instance_names = ["backend", "frontend", "database"]

  # 2. Find the index of "frontend" (Returns 1 because lists are 0-indexed)
  frontend_index = index(local.instance_names, "frontend")
  
  # 3. Use that index to look up the matching IP address from a separate list
  instance_ips = ["192.0.2.1", "192.0.2.2", "192.0.2.3"]
  frontend_ip  = local.instance_ips[local.frontend_index]
}

output "frontend_position" {
  value = local.frontend_index # Outputs: 1
}

output "frontend_ip_address" {
  value = local.frontend_ip # Outputs: "192.0.2.2"
}*/

