# Create a Private Subnets
resource "aws_subnet" "csye6225_private_subnet" {
  count             = var.private_subnet_count
  vpc_id            = aws_vpc.csye6225_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.environment}-csye6225-private-subnet-${count.index + 1}"
  }
}