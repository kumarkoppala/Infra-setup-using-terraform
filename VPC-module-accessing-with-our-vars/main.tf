module "vpc" {
    source = "../VPC-SETUP-MODULE-PLATFORM-ENGINEER"
    project = var.project
    env = var.env
}