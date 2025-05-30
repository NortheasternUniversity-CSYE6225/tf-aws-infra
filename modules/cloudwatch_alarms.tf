# Create a CloudWatch alarm to trigger if the average CPU utilization is above 8% for 60 seconds
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "cpu-utilization-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.asg_scale_up_threshold
  alarm_description   = "Scale up if CPU > 8%"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.webapp_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_up.arn]
}

# Ceate a CloudWatch alarm to trigger if the average CPU utilization is below 6.5% for 60 seconds
resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "cpu-utilization-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.asg_scale_down_threshold
  alarm_description   = "Scale down if CPU < 6.5%"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.webapp_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_down.arn]
}
