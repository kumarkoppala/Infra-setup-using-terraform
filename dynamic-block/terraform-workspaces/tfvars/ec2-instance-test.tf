resource "aws_instance" "roboshop" {
    ami = local.ami
    instance_type = var.instance_type
    tags = local.tags
    
}

