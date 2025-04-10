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

# Create a launch template for the web application instances
resource "aws_launch_template" "webapp_lt" {
  name_prefix   = "csye6225_asg"
  image_id      = var.custom_ami_id
  instance_type = var.ec2_instance_type
  key_name      = aws_key_pair.this.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_webapp_profile.name
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = var.volume_size
      volume_type           = var.volume_type
      delete_on_termination = var.delete_on_termination
      encrypted             = true
      kms_key_id            = aws_kms_key.ec2_key.arn
    }
  }

  depends_on = [aws_kms_key.ec2_key]

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.app_sg.id]
  }

  monitoring {
    enabled = true
  }

  user_data = base64encode(templatefile("${path.module}/scripts/userData.sh", {
    DB_HOST        = aws_db_instance.postgres16_rds.address,
    DB_PORT        = aws_db_instance.postgres16_rds.port,
    DB_NAME        = aws_db_instance.postgres16_rds.db_name,
    DB_USERNAME    = aws_db_instance.postgres16_rds.username,
    S3_BUCKET_NAME = aws_s3_bucket.bucket.id,
    REGION         = var.region,
    SECRET_ID      = aws_secretsmanager_secret.secret_string.name
  }))
}
