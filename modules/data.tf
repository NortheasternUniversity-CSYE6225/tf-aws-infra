# Available availability zones in a region
data "aws_availability_zones" "available" {
  state = var.az_state
}

# Get the DNS zone ID 
data "aws_route53_zone" "dns_zone" {
  name         = var.zone_name
  private_zone = false
}

# Inject account ID dynamically
data "aws_caller_identity" "current" {}