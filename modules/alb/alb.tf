resource "aws_lb" "suvi-tf-alb" {
  name               = "tf-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg-id]
  subnets            = [var.public-subnet-id, var.private-subnet-id]
  
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
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "OK"
    }
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
  vpc_id      = var.vpc-id
  

tags = {
    Name = "suvi-tf-tg"
  }
}

# Attach Target Group to Listener
resource "aws_lb_listener_rule" "suvi-tg-attach" {
  listener_arn = aws_lb_listener.suvi-tf-lb-listner.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.suvi-tf-tg.arn
  }
   condition {
    host_header {
      values = ["*"]
    }
  }
  
}