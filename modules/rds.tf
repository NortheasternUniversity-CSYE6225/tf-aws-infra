# Create a Subnet Group for RDS (Private Subnets)
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = aws_subnet.private_subnet[*].id

  tags = {
    Name = "rds-subnet-group"
  }
}

# Generate a random password for RDS
resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "!#%^&*()-_=+[]{}<>?"
}

# Generate a random name for the secret in AWS Secrets Manager
resource "random_string" "secret_name" {
  length           = 16
  special          = true
  override_special = "/@£$"
}

# Create a secret in AWS Secrets Manager for RDS password
resource "aws_secretsmanager_secret" "secret_string" {
  name        = random_string.secret_name.result
  description = "RDS password for Spring Boot App"
  kms_key_id  = aws_kms_key.secrets_manager_key.arn
}

# Create a secret version in AWS Secrets Manager for RDS password
resource "aws_secretsmanager_secret_version" "rds_password_version" {
  secret_id     = aws_secretsmanager_secret.secret_string.id
  secret_string = jsonencode({ password = random_password.rds_password.result })
}


# Create RDS Instance
resource "aws_db_instance" "postgres16_rds" {
  identifier        = "csye6225"
  engine            = var.rds_engine
  engine_version    = var.rds_engine_version
  instance_class    = var.rds_instance_class
  allocated_storage = var.rds_allocated_storage
  storage_type      = var.rds_storage_type
  storage_encrypted = true
  kms_key_id        = aws_kms_key.db_key.arn

  depends_on = [
    aws_kms_key.db_key
  ]

  multi_az               = false
  publicly_accessible    = false
  db_name                = var.rds_name
  username               = var.rds_username
  password               = random_password.rds_password.result
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  parameter_group_name   = aws_db_parameter_group.postgres16.name
  skip_final_snapshot    = true

  tags = {
    Name = "postgres16_rds"
  }
}
