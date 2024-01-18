module "vpc" {

    source                      = "./modules/vpc/"
    vpc-cidr                    = var.vpc-cidr
    private-subnet-cidr         = var.private-subnet-cidr
    private-subnet-az           = var.private-subnet-az
    public-subnet-az            = var.public-subnet-az
    ssh-port                    = var.ssh-port
    http-port                   = var.http-port
    allow-all-cidr              = var.allow-all-cidr
    public-subnet-cidr          = var.public-subnet-cidr
}

module "alb" {

    source                      = "./modules/alb/"
    tg-port                     = var.tg-port
    tg-protocol                 = var.tg-protocol
    listner-port                = var.listner-port
    listner-protocol            = var.listner-protocol
    sg-id                       = module.vpc.sg-id
    public-subnet-id            = module.vpc.public-subnet-id
    private-subnet-id           = module.vpc.private-subnet-id
    vpc-id                      = module.vpc.vpc-id
}