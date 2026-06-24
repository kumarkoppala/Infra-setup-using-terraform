variable "ami_id" {
    type = string
    default = "ami-0220d79f3f480ecf5"
    description = "rhel devops image"
    validation {
    condition = length(var.ami_id) > 4 && substr(var.ami_id, 0, 4) == "ami-"
    error_message = "The ami_id value must be a valid AMI ID, starting with \"ami-\"."
  }
}

variable "instance_type" {
    type = string
    default = "t3.micro"
    
}


variable "sg_port" {
    type = number
    default = 22
}

variable "zone_id" {
  type = string
  default = "Z02019713PAOKQAQBZ7L9"
}

/* variable "instances" {
  type = list(any)
  default = ["mongodb","redis", "mysql","rabbitmq","catalogue","user","cart","shipment","payment","frontend"]
} */

variable "instances" {
  default = {
    mongodb = {
      instance_type = "t3.micro"
      ami           = "ami-0220d79f3f480ecf5"
      },
    redis = {
      instance_type = "t3.micro"
      ami           = "ami-0220d79f3f480ecf5"
      },
    mysql = {
      instance_type = "t3.micro"
      ami           = "ami-0220d79f3f480ecf5"
      },
    rabbitmq = {
      instance_type = "t3.micro"
      ami           = "ami-0220d79f3f480ecf5"
      },
    catalogue = {
      instance_type = "t3.micro"
      ami           = "ami-0220d79f3f480ecf5"
      },
    user = {
      instance_type = "t3.micro"
      ami           = "ami-0220d79f3f480ecf5"
      },
    cart = {
      instance_type = "t3.micro"
      ami           = "ami-0220d79f3f480ecf5"
      },
    shipping = {
      instance_type = "t3.micro"
      ami           = "ami-0220d79f3f480ecf5"
      },
    payment = {
      instance_type = "t3.micro"
      ami           = "ami-0220d79f3f480ecf5"
      },
    frontend = {
      instance_type = "t3.micro"
      }
  }
}



variable "cidr_block" {
    default = ["152.59.198.91/32"]  
    type = list(any)
}

variable "project" {
  type = string
  default = "roboshop"
  validation {
    condition = can(regex("^[A-Za-z0-9-]{2,10}$", var.project))
    error_message = "Project name must 2 to 10 characters"
  }
}

variable "env" {
  type        = string
  description = "Deployment environment name"
  default     = "dev"

  validation {
    condition = contains(["dev", "staging", "prod"], var.env)
    error_message = "Environment must be dev, staging, or prod."
  }
}