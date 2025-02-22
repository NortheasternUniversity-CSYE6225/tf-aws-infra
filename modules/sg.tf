# Application Security Group
resource "aws_security_group" "app_sg" {
  name        = "application-security-group"
  description = "Security group for web application"
  vpc_id      = aws_vpc.csye6225_vpc.id

  # SSH access
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = var.ssh_port_cidr
  }

  # HTTP access
  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = var.http_port_cidr
  }

  # HTTPS access
  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = var.https_port_cidr
  }

  # Application port access
  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = var.app_port_cidr
  }

  #   # Outbound traffic
  #   egress {
  #     from_port   = 0
  #     to_port     = 0
  #     protocol    = "-1"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }

  tags = {
    Name = "application-security-group"
  }
}