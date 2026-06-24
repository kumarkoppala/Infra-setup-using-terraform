variable "project" {
    type = string
}
variable "env" {
    type = string
}

variable "public_cidrs" {
    type = list(string)
}

variable "private_cidrs" {
    type = list(string)
}

variable "database_cidrs" {
    type = list(string)
}

