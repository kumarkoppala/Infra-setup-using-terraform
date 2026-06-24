resource "aws_instance" "roboshop" {
  for_each = var.instances
  ami           = var.ami_id
  instance_type = each.value.instance_type
  #instance_type = var.instance_type
  #count = length(var.instances)
  tags = {
    Name = each.key
    Env  = var.env
  }
  vpc_security_group_ids = ["sg-0e004e87405eb1841", aws_security_group.sg-myip[each.key].id]
}

resource "aws_security_group" "sg-myip" {
  #count = length(var.instances)
  for_each = var.instances
  tags = {
    Name = each.key
    Env  = "test"
  }
  ingress {
    from_port   = var.sg_port
    to_port     = var.sg_port
    protocol    = "tcp"
    cidr_blocks = var.cidr_block
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
