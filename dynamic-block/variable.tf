variable "project" {
    type = string
    default = "roboshop"
}

variable "env" {
    type = string
    default = "dev"
}

variable "common_tags" {
    type = map(any)
    default = {
        project = "roboshop"
        env = "dev"
    }
}



variable "sg" {
    type = map(any)
    default = {
        ssh = {
            port = 22
            cidr = ["0.0.0.0/0"]
            protocol = "tcp"
        }
        http = {
            port = 80
            cidr = ["0.0.0.0/0"]
            protocol = "tcp"
        }
    }
}

variable "instances" {
    type = map(any)
    default = {
        mongo = {
            instance_type = "t3.micro"
            ami = "ami-kfkdfdkdffmdk"
        }
        frontend = {
            instance_type = "t3.small"
            ami = "ami-kfkdfdkdffmdk"
        }
    }
}




