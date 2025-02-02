provider "aws" {
    region = "eu-west-3"
}

# Create vpc 
resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "${var.project}-vpc"
        env = var.env
    }
}

# Create Private Subnet
resource "aws_subnet" "private_subnet" {
    vpc_id     = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet_cidr

    tags = {
        env = var.env
        Name = "${var.project}-private-subnet"
    }
}

# Create Public Subnet
resource "aws_subnet" "public_subnet" {
    vpc_id     = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet_cidr
    map_public_ip_on_launch = true
    tags = {
        env = var.env
        Name = "${var.project}-public-subnet"
    }
}

# Create Internet Getway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    env = var.env
    Name = "${var.project}-igw"
  }
}

# Create Rout Table
resource "aws_route" "igw_route" {
  route_table_id            = aws_vpc.my_vpc.default_route_table_id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my_igw.id
}

# Create Security Group
resource "aws_security_group" "my_sg" {
    name = "${var.project}-sg"
    description = "allow http and ssh"
    vpc_id = aws_vpc.my_vpc.id
    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "TCP"
        from_port = 22
        to_port = 22
    }
    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "TCP"
        from_port = 80
        to_port = 80
    }
    egress {
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "-1"
        from_port = 0
        to_port = 0
    }
    depends_on = [aws_internet_gateway.my_igw]
}

# Lounch instance
resource "aws_instance" "instance_1" {
    ami = var.image_id
    instance_type = var.instance_type
    key_name = var.key_pair
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    tags = {
        Name = "${var.project}-private-instance"
        env = var.env
    }
    subnet_id = aws_subnet.private_subnet.id
}

resource "aws_instance" "instance_2" {
    ami = var.image_id
    instance_type = var.instance_type
    key_name = var.key_pair
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    tags = {
        Name = "${var.project}-public-instance"
        env = var.env
    }
    subnet_id = aws_subnet.public_subnet.id
}