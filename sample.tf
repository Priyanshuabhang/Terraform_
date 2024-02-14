provider "aws" {
     region = "ap-south-1"
}

# Create Security Group
resource "aws_security_group" "my_sg" {
    name = "my-sec-group"
    description = "allow-ssh and http"
    vpc_id = var.vpc_id
    ingress {
        protocol = "TCP"
        from_port = 22
        to_port  = 22
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        protocol = "TCP"
        from_port = "80"
        to_port  = "80"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        protocol = "-1"  
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}


# Launch AWS instance 
resource "aws_instance" "my_instance" {
    ami = var.image_id
    instance_type = var.machine_type
    key_name = "priyanshu"
    vpc_security_group_ids = ["sg-09ab8dd55ab1c4f0b", aws_security_group.my_sg.id]
    tags = {
        Name = "my-instance"
        env = "dev"
    }
}

resource "aws_instance" "another_instance" {
    ami = var.image_id
    instance_type = var.machine_type
    key_name = "priyanshu"
    vpc_security_group_ids = ["sg-09ab8dd55ab1c4f0b"]
    tags = {
        Name = "another-instance"
        env = "dev"
    }
}

# Variables

variable "image_id" {
    default = "ami-03f4878755434977f"
}

variable "machine_type" {
    default = "t2.micro"
}

variable "vpc_id" {
    default = "vpc-0f0f8d7ace9adb154"
}
