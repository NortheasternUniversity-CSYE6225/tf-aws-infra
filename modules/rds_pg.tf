# Create RDS Parameter Group
resource "aws_db_parameter_group" "postgres16" {
  name   = "postgres16-params"
  family = "postgres16"

  parameter {
    name  = "log_statement"
    value = "all"
  }

  parameter {
    name  = "log_connections"
    value = "1"
  }

  tags = {
    Name = "postgres16-parameter-group"
  }
}