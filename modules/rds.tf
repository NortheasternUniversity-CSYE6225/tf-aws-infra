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

# Create RDS Instance
resource "aws_db_instance" "postgres16_rds" {
  identifier             = "csye6225"
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  instance_class         = var.rds_instance_class
  allocated_storage      = var.rds_allocated_storage
  storage_type           = var.rds_storage_type
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
