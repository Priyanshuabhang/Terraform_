provider "aws" {
     region = "eu-west-3"
}

# Launch AWS instance 
resource "aws_instance" "my_instance" {
    ami = var.image_id
    instance_type = var.machine_type
    key_name = "shubham"
    vpc_security_group_ids = ["sg-0bbdb99d529d27057"]
    tags = {
        Name = "my-instance"
        env = "dev"
    }
}

resource "aws_instance" "another_instance" {
    ami = var.image_id
    instance_type = var.machine_type
    key_name = "shubham"
    vpc_security_group_ids = ["sg-0bbdb99d529d27057"]
    tags = {
        Name = "another-instance"
        env = "dev"
    }
}

# Variables

variable "image_id" {
    default = "ami-089c89a80285075f7"
}

variable "machine_type" {
    default = "t2.micro"
}

variable "vpc_id" {
    default = "vpc-0e110ef78b813e6d3"
}
