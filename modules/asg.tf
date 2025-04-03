# Create an Auto Scaling Group for the web application instances
resource "aws_autoscaling_group" "webapp_asg" {
  name                      = "webapp-asg"
  max_size                  = var.asg_max_capacity
  min_size                  = var.asg_min_capacity
  desired_capacity          = var.asg_desired_capacity
  vpc_zone_identifier       = [for subnet in aws_subnet.public_subnet : subnet.id]
  health_check_type         = "ELB"
  health_check_grace_period = var.asg_grace_period
  default_cooldown          = var.asg_cooldown_period
  target_group_arns         = [aws_lb_target_group.webapp_tg.arn]

  launch_template {
    id      = aws_launch_template.webapp_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "webapp-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
