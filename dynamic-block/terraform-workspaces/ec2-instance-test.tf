resource "aws_instance" "roboshop" {
    ami = local.ami
    instance_type = lookup(var.instance_type, local.env)
    tags = local.tags

}

