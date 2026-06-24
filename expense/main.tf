resource "aws_instance" "roboshop" {
  for_each               = var.instances
  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  vpc_security_group_ids = [aws_security_group.roboshop-common.id, aws_security_group.sg-instance[each.key].id]
  tags = merge(
    var.common_tags,
    var.ec2_tags,
    {
      Name = "${var.common_tags["project"]}-${var.common_tags["env"]}-${each.key}"
    }
  )
}

resource "aws_security_group" "roboshop-common" {
  name = "roboshop-common"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg-instance" {
  for_each = var.instances
  name     = "${var.common_tags["project"]}-${var.common_tags["env"]}-${each.key}"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}