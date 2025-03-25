# Generate a new private key
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create AWS key pair using the generated public key
resource "aws_key_pair" "this" {
  key_name   = "my-windows-key-pair"
  public_key = tls_private_key.this.public_key_openssh
}

# Save private key to local file
resource "local_file" "private_key" {
  content  = tls_private_key.this.private_key_pem
  filename = "${path.module}/my-windows-key-pair.pem"
}

# EC2 Instance
resource "aws_instance" "webapp_ec2" {
  ami                    = var.custom_ami_id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.public_subnet[var.target_subnet_index].id
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name               = aws_key_pair.this.key_name
  iam_instance_profile   = aws_iam_instance_profile.webapp_s3_profile.name

  root_block_device {
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    delete_on_termination = var.delete_on_termination
  }

  disable_api_termination = var.disable_api_termination

  user_data = templatefile("${path.module}/scripts/userData.sh", {
    DB_HOST        = aws_db_instance.postgres16_rds.address,
    DB_PORT        = aws_db_instance.postgres16_rds.port,
    DB_NAME        = aws_db_instance.postgres16_rds.db_name,
    DB_USERNAME    = aws_db_instance.postgres16_rds.username,
    DB_PASSWORD    = random_password.rds_password.result,
    S3_BUCKET_NAME = aws_s3_bucket.bucket.id,
    REGION      = var.region
  })

  tags = {
    Name = "webapp-instance"
  }
}