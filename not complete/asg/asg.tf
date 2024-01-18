# Auto Scaling Group
resource "aws_launch_configuration" "suvi-tf-lc" {
  name = "suvi-lc"

  image_id = var.lc-ami-id

  
}

resource "aws_autoscaling_group" "suvi-tf-asg" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  launch_configuration = aws_launch_configuration.suvi-tf-lc.id
  vpc_zone_identifier  = [module.vpc.private-subnet-id]
  health_check_type    = "EC2"
  health_check_grace_period = 300

  
}