resource "aws_security_group" "roboshop" {
    for_each = var.instances
    name = "${var.project}-${var.env}-${each.key}"
    tags = local.tags
    
    dynamic "ingress" {
        for_each = var.sg
        content {
        from_port = ingress.value.port
        to_port = ingress.value.port
        protocol = ingress.value.protocol
        cidr_blocks = ingress.value.cidr
        }
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    provisioner "local-exec" {
    
    command = "echo ${self.id}"
}
provisioner "local-exec" {
    when = destroy
    command = "echo sg :${self.id} destroyed"
}
}

