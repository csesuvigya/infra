variable "vpc-cidr" {
    default = "10.0.0.0/16"
}

variable "private-subnet-cidr" {

    default = "10.0.1.0/24"
}

variable "public-subnet-az" {

    default = "us-east-1a"
}

variable "private-subnet-az" {

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

variable "public-subnet-cidr" {
    default = "10.0.2.0/24"
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