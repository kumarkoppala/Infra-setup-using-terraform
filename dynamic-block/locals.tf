locals {
    Name = "${var.project}-${var.env}"
    tags = merge(
        var.common_tags,
        {
            Name = "${var.project}-${var.env}"
        }
    )

}