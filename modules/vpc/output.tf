output "vpc-id" {

    value = aws_vpc.suvi-tf-vpc.id
}

output "sg-id" {
    value = aws_security_group.suvi-tf-sg.id
}

output "alb-subnet1-id" {
    value = aws_subnet.suvi-tf-alb-subnet-az1.id
}


output "alb-subnet2-id" {
    value = aws_subnet.suvi-tf-alb-subnet-az2.id
}

output "ecs-subnet1-id" {
    value = aws_subnet.suvi-tf-ecs-private-subnet-az1.id
}


output "ecs-subnet2-id" {
    value = aws_subnet.suvi-tf-ecs-private-subnet-az2.id
}