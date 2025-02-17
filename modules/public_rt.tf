# Create a Public Route Table
resource "aws_route_table" "csye6225_public_rt" {
    vpc_id = aws_vpc.csye6225_vpc.id

    route {
        cidr_block = var.public_route
        gateway_id = aws_internet_gateway.csye6225_igw.id
    }

    tags = {
        Name = "${var.environment}-csye6225-public-rtb"
    }
}

# Public Route Table Associations
resource "aws_route_table_association" "csye6225_public_rt_association" {
    count          = var.public_subnet_count
    subnet_id      = aws_subnet.csye6225_public_subnet[count.index].id
    route_table_id = aws_route_table.csye6225_public_rt.id
}