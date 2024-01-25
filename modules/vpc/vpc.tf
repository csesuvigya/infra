resource "aws_vpc" "suvi-tf-vpc" {
  cidr_block       = var.vpc-cidr
  

  tags = {
    Name = "suvi-tf-vpc"
  }
}

resource "aws_subnet" "suvi-tf-alb-subnet-az1" {
  vpc_id                  = aws_vpc.suvi-tf-vpc.id
  cidr_block              = var.alb-subnet-az1-cidr
  availability_zone       = var.alb-subnet-az1  
  map_public_ip_on_launch = false
  tags = {
    Name = "suvi-tf-alb-subnet"
  }

}
resource "aws_subnet" "suvi-tf-alb-subnet-az2" {
  vpc_id                  = aws_vpc.suvi-tf-vpc.id
  cidr_block              = var.alb-subnet-az2-cidr
  availability_zone       = var.alb-subnet-az2  
  map_public_ip_on_launch = false
  tags = {
    Name = "suvi-tf-alb-subnet"
  }

}

resource "aws_subnet" "suvi-tf-ecs-private-subnet-az1" {
  vpc_id                  = aws_vpc.suvi-tf-vpc.id
  cidr_block              = var.ecs-private-subnet-az1-cidr
  availability_zone       = var.ecs-subnet-az1  
  map_public_ip_on_launch = false
  tags = {
    Name = "suvi-tf-private-subnet"
  }

}

resource "aws_subnet" "suvi-tf-ecs-private-subnet-az2" {
  vpc_id                  = aws_vpc.suvi-tf-vpc.id
  cidr_block              = var.ecs-private-subnet-az2-cidr
  availability_zone       = var.ecs-subnet-az2  
  map_public_ip_on_launch = false

  tags = {
    Name = "suvi-tf-private-subnet"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "suvi-tf-igw" {
  vpc_id = aws_vpc.suvi-tf-vpc.id

  tags = {
    Name = "suvi-tf-igw"
  }
}


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

resource "aws_route_table_association" "suvi-tf-public_subnet_association" {
  subnet_id      = aws_subnet.suvi-tf-ecs-private-subnet-az1.id
  route_table_id = aws_route_table.suvi-tf-public_route_table.id
}

resource "aws_route_table_association" "suvi-tf-public_subnet_association1" {
  subnet_id      = aws_subnet.suvi-tf-ecs-private-subnet-az2.id
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
   ingress {
    from_port   = var.container-port
    to_port     = var.container-port
    protocol    = "tcp"
    cidr_blocks = [var.allow-all-cidr]
  }

  tags = {
    Name = "suvi-tf-sg"
  }
}