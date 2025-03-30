# Create an Auto Scaling policy for scaling up the ASG
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up-policy"
  scaling_adjustment     = var.asg_scale_up_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.webapp_asg.name
  policy_type            = "SimpleScaling"

  metric_aggregation_type = "Average"
}

# Create a scaling policy to scale down the Auto Scaling Group
resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale-down-policy"
  scaling_adjustment     = var.asg_scale_down_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.webapp_asg.name
  policy_type            = "SimpleScaling"

  metric_aggregation_type = "Average"
}
