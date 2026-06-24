locals {
    ami = "ami-0220d79f3f480ecf5"
    tags = {
        project = "var.project"
        Name = "${var.project}-${var.env}"
      }
}