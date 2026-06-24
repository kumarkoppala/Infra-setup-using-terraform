variable "project" {
    type = string
}
variable "env" {
    type = string
}

variable "ec2_tags" {
    type = map
    default = {}
}

variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_tags" {
    type = map
    default = {}
}

variable "igw_tags" {
    type = map
    default = {}
}

variable "public_cidrs" {
    type = list
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "public_subnets_tags" {
    type = map
    default = {}
}

variable "private_cidrs" {
    type = list
    default = ["10.0.11.0/24", "10.0.12.0/24"]
}
variable "private_subnets_tags" {
    type = map
    default = {}
}

variable "database_cidrs" {
    type = list
    default = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "database_subnets_tags" {
    type = map
    default = {}
}

