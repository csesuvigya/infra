# OVERVIEW

This repo has terraform codes to provision resources on AWS cloud. I have made the structure modular so its reusable and easy to investigate individual components. 

Currently there are three modules-
- ALB       # to provision application load balancer
- VPC       # this module contails all the network configurations like subnets, internet gateways, security groups etc
- ECS       # creates ecs clusters and task definitions to deploy apps on containers. 

Note- You can expect frequest changes to this terraform code as I'm continously integrating new code.

# Running the code

Once you have cloned this repo to your local check if already have terraform installed. 

Run the below comand to initialize terraform (make sure you edit the backend information and use your aws credentials)

> terraform init

After the initialization, run the plan command to check the plan.

> terraform plan

Now, apply the terraform script to provision the resources.

> terraform apply

