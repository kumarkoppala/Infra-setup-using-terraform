locals {
    common_tags = {
        Project = var.project
        Env = var.env
        Name = local.name
    }
    azs = slice(data.aws_availability_zones.azs.names, 0, 2)
    name = "${var.project}-${var.env}"
}
