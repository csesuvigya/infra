variable "vpc-cidr" {
    default = "10.0.0.0/16"
}

variable "alb-subnet-az1-cidr" {

    default = "10.0.1.0/24"
}

variable "alb-subnet-az2-cidr" {

    default = "10.0.2.0/24"
}

variable "ecs-private-subnet-az1-cidr" {

    default = "10.0.3.0/24"
}

variable "ecs-private-subnet-az2-cidr" {

    default = "10.0.4.0/24"
}



variable "alb-subnet-az1" {

    default = "us-east-1a"
}

variable "alb-subnet-az2" {

    default = "us-east-1b"
}

variable "ecs-subnet-az1" {

    default = "us-east-1a"
}

variable "ecs-subnet-az2" {

    default = "us-east-1b"
}

variable "ssh-port" {
    default = "22"
}
variable "http-port" {
    default = "80"
}
variable "allow-all-cidr" {
    default = "0.0.0.0/0"
}


variable "tg-port" {
    default = "80"
}
variable "tg-protocol" {
    default = "HTTP"
}
variable "listner-port" {
    default = "80"
}

variable "listner-protocol" {
    default = "HTTP"
}

#ecs variables

variable "ecr-url" {
    default = "866934333672.dkr.ecr.us-east-1.amazonaws.com/suvi-ecr-repo"
}