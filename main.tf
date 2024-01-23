module "vpc" {

    source                      = "./modules/vpc/"
    vpc-cidr                    = var.vpc-cidr
    alb-subnet-az1-cidr         = var.alb-subnet-az1-cidr
    alb-subnet-az2-cidr         = var.alb-subnet-az2-cidr
    ecs-private-subnet-az1-cidr = var.ecs-private-subnet-az1-cidr
    ecs-private-subnet-az2-cidr = var.ecs-private-subnet-az2-cidr
    alb-subnet-az1              = var.alb-subnet-az1
    alb-subnet-az2              = var.alb-subnet-az2
    ecs-subnet-az1              = var.ecs-subnet-az1
    ecs-subnet-az2              = var.ecs-subnet-az2
    ssh-port                    = var.ssh-port
    http-port                   = var.http-port
    allow-all-cidr              = var.allow-all-cidr
    
}

module "alb" {

    source                      = "./modules/alb/"
    tg-port                     = var.tg-port
    tg-protocol                 = var.tg-protocol
    listner-port                = var.listner-port
    listner-protocol            = var.listner-protocol
    sg-id                       = module.vpc.sg-id
    alb-subnet1-id              = module.vpc.alb-subnet1-id
    alb-subnet2-id              = module.vpc.alb-subnet2-id
    vpc-id                      = module.vpc.vpc-id
}

module "ecs" {

    source                      = "./modules/ecs/"
    ecr-url                     = var.ecr-url
    ecs-subnet1-id              = module.vpc.ecs-subnet1-id
    ecs-subnet2-id              = module.vpc.ecs-subnet2-id
    lb-arn                      = module.alb.lb-arn
    sg-id                       = module.vpc.sg-id
    tg-arn                      = module.alb.tg-arn
}