/*variable "ami_id" {
    type = string
    default = "ami-0220d79f3f480ecf5"
    description = "rhel devops image"
    validation {
    condition = length(var.ami_id) > 4 && substr(var.ami_id, 0, 4) == "ami-"
    error_message = "The ami_id value must be a valid AMI ID, starting with \"ami-\"."
  }
}*/

variable "instances" {
  type = map(any)
  default = {
    database = {
      instance_type = "t3.micro"
      ami = "ami-0220d79f3f480ecf5"
    },
    backend = {
      instance_type = "t3.micro"
      ami = "ami-0220d79f3f480ecf5"
    },
    frontend = {
      instance_type = "t3.micro"
      ami = "ami-0220d79f3f480ecf5"
    },
    lb = {
      instance_type = "t3.micro"
      ami = "ami-0220d79f3f480ecf5"
    }
  }
}

variable "common_tags" {
  type = map(any)
  default = {
    project = "expense"
    env     = "dev"
  }
}
variable "ec2_tags" {
  type = map(any)
  default = {
    region = "us-east-1"
  }
}

variable "zone_id" {
  type    = string
  default = "Z02019713PAOKQAQBZ7L9"
}