# Application Security Group
resource "aws_security_group" "app_sg" {
  name        = "application-security-group"
  description = "Security group for web application"
  vpc_id      = aws_vpc.csye6225_vpc.id

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_port_cidr
  }

  # HTTP access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.http_port_cidr
  }

  # HTTPS access
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.https_port_cidr
  }

  # Application port access
  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "abcd"
      cidr_blocks = var.app_port_cidr
  } 

  tags = {
    Name = "application-security-group"
  }
}