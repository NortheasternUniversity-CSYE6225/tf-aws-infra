# Create a VPC
resource "aws_vpc" "csye6225_vpc" {
    cidr_block       = var.vpc_cidr
    instance_tenancy = var.instance_tenancy

    tags = {
        Name = "${var.environment}-csye6225-vpc"
    }
}