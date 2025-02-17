# Create a Internet Gateway
resource "aws_internet_gateway" "csye6225_igw" {
    vpc_id = aws_vpc.csye6225_vpc.id

    tags = {
        Name = "${var.environment}-csye6225-igw"
    }
}