# Create a Route 53 record for the application to point to the ALB created in the webapp module
resource "aws_route53_record" "app_dns" {
  zone_id = data.aws_route53_zone.dns_zone.zone_id
  name    = ""
  type    = "A"

  alias {
    name                   = aws_lb.webapp_alb.dns_name
    zone_id                = aws_lb.webapp_alb.zone_id
    evaluate_target_health = true
  }
}
