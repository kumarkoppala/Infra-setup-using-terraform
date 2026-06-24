locals {
    common_tags = {
        Project = var.project
        Env = var.env
        Name = local.common_name
        Terraform = "true"
    }
    azs = slice(data.aws_availability_zones.azs.names, 0, 2)
    common_name = "${var.project}-${var.env}"
}