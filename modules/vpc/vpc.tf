resource "aws_vpc" "suvi-tf-vpc" {
  cidr_block       = var.vpc-cidr
  

  tags = {
    Name = "suvi-tf-vpc"
  }
}

resource "aws_subnet" "suvi-tf-private_subnet" {
  vpc_id                  = aws_vpc.suvi-tf-vpc.id
  cidr_block              = var.private-subnet-cidr
  availability_zone       = var.private-subnet-az  
  map_public_ip_on_launch = false
  tags = {
    Name = "suvi-tf-private-subnet"
  }

}

resource "aws_subnet" "suvi-tf-public_subnet" {
  vpc_id                  = aws_vpc.suvi-tf-vpc.id
  cidr_block              = var.public-subnet-cidr
  availability_zone       = var.public-subnet-az  
  map_public_ip_on_launch = true

  tags = {
    Name = "suvi-tf-public-subnet"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "suvi-tf-igw" {
  vpc_id = aws_vpc.suvi-tf-vpc.id

  tags = {
    Name = "suvi-tf-igw"
  }
}


# Create a route table for the public subnet
resource "aws_route_table" "suvi-tf-public_route_table" {
  vpc_id = aws_vpc.suvi-tf-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.suvi-tf-igw.id
  }

  tags = {
    Name = "suvi-tf-public-route-table"
  }
}

# Associate the public route table with the public subnet
resource "aws_route_table_association" "suvi-tf-public_subnet_association" {
  subnet_id      = aws_subnet.suvi-tf-public_subnet.id
  route_table_id = aws_route_table.suvi-tf-public_route_table.id
}


# Security Groups
resource "aws_security_group" "suvi-tf-sg" {
  name        = "suvi-tf-sg"
  vpc_id      = aws_vpc.suvi-tf-vpc.id
  description = "Allow http and  traffic to the instances"

  ingress {
    from_port   = var.ssh-port
    to_port     = var.ssh-port
    protocol    = "tcp"
    cidr_blocks = [var.allow-all-cidr]
  }
  ingress {
    from_port   = var.http-port
    to_port     = var.http-port
    protocol    = "tcp"
    cidr_blocks = [var.allow-all-cidr]
  }

  tags = {
    Name = "suvi-tf-sg"
  }
}