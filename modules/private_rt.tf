# Create a Private Route Table
resource "aws_route_table" "csye6225_private_rt" {
  vpc_id = aws_vpc.csye6225_vpc.id

  tags = {
    Name = "${var.environment}-csye6225-private-rtb"
  }
}

# Private Route Table Associations
resource "aws_route_table_association" "csye6225_private_rt_association" {
  count          = var.private_subnet_count
  subnet_id      = aws_subnet.csye6225_private_subnet[count.index].id
  route_table_id = aws_route_table.csye6225_private_rt.id
}