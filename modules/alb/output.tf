

output "tg-arn" {

    value = aws_lb_target_group.suvi-tf-tg.arn
}

output "lb-arn" {
    value = aws_lb.suvi-tf-alb.arn
}