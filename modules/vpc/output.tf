output "vpc-id" {

    value = aws_vpc.suvi-tf-vpc.id
}

output "sg-id" {
    value = aws_security_group.suvi-tf-sg.id
}

output "private-subnet-id" {
    value = aws_subnet.suvi-tf-private_subnet.id
}


output "public-subnet-id" {
    value = aws_subnet.suvi-tf-public_subnet.id
}