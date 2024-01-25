resource "aws_lb" "suvi-tf-alb" {
  name               = "tf-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg-id]
  subnets            = [var.ecs-subnet1-id, var.ecs-subnet2-id]
  
  enable_deletion_protection = false

  tags = {
    Name = "suvi-tf-alb"
  }
}

# Listener
resource "aws_lb_listener" "suvi-tf-lb-listner" {
  load_balancer_arn = aws_lb.suvi-tf-alb.arn
  port              = var.listner-port
  protocol          = var.listner-protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.suvi-tf-tg.arn
  }

  tags = {
    Name = "suvi-tf-lb-listner"
  }
}

# Target Group
resource "aws_lb_target_group" "suvi-tf-tg" {
  name        = "suvi-lb-target-group"
  port        = var.tg-port
  protocol    = var.tg-protocol
  target_type = "ip"
  vpc_id      = var.vpc-id
  

tags = {
    Name = "suvi-tf-tg"
  }
}

