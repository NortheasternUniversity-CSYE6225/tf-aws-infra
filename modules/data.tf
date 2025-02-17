# Available availability zones in a region
data "aws_availability_zones" "available" {
  state = var.az_state
}