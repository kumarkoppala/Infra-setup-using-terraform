locals {
    ami = "ami-0220d79f3f480ecf5"
    env = terraform.workspace
    project = "roboshop"
    tags = {
        project = "local.project"
        Name = "${local.project}-${local.env}"
      }
}
