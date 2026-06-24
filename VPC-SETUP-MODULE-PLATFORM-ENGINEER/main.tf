resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.vpc_tags,
    local.common_tags
)
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.igw_tags,
    local.common_tags
  )
}
resource "aws_subnet" "public_subnets" {
  count = length(var.public_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidrs[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true # Automatically assigns a public IP to instances

  tags = merge(
    var.public_subnets_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.env}-public"
    }
  )
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_cidrs[count.index]
  availability_zone       = local.azs[count.index]
  tags = merge(
    var.private_subnets_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.env}-private"
    }
  )
}

resource "aws_subnet" "database_subnets" {
  count = length(var.database_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.database_cidrs[count.index]
  availability_zone       = local.azs[count.index]
  tags = merge(
    var.database_subnets_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.env}-database"
    }
  )
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.env}-public"
    }
  )

}
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.env}-private"
    }
  )
}

resource "aws_route_table" "database_rt" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.env}-database"
    }
  )
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public_subnets)  
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private_subnets)  
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_route_table_association" "database" {
  count = length(aws_subnet.database_subnets)  
  subnet_id      = aws_subnet.database_subnets[count.index].id
  route_table_id = aws_route_table.database_rt.id
}

resource "aws_eip" "eip" {
  domain   = "vpc"

  tags = local.common_tags
    
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = local.common_tags

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id # Replace with your Internet Gateway ID
}
resource "aws_route" "private" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.ngw.id # Replace with your Internet Gateway ID
}
resource "aws_route" "database" {
  route_table_id         = aws_route_table.database_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.ngw.id # Replace with your Internet Gateway ID
}








