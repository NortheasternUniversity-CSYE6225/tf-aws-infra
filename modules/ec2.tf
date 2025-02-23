# EC2 Instance
resource "aws_instance" "webapp_ec2" {
  ami                    = var.custom_ami_id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.csye6225_public_subnet[0].id
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  root_block_device {
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    delete_on_termination = var.delete_on_termination
  }

  disable_api_termination = var.disable_api_termination

  tags = {
    Name = "webapp-instance"
  }
}