# Create a VPC
resource "aws_vpc" "csye6225_vpc" {
  cidr_block           = "256.0.0.0/16"
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment}-csye6225-vpc"
  }
}