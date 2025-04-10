resource "aws_kms_key" "ec2_key" {
  description             = "KMS key for EC2"
  enable_key_rotation     = true
  deletion_window_in_days = 7

  policy = templatefile("${path.module}/scripts/ec2-kms-policy.json.tpl", {
    account_id = data.aws_caller_identity.current.account_id
  })

  tags = {
    Name = "ec2-key"
  }
}

resource "aws_kms_alias" "ec2_alias" {
  name          = "alias/ec2-key"
  target_key_id = aws_kms_key.ec2_key.key_id
}

resource "aws_kms_key" "db_key" {
  description             = "KMS key for RDS"
  enable_key_rotation     = true
  deletion_window_in_days = 7

  policy = templatefile("${path.module}/scripts/db-kms-policy.json.tpl", {
    account_id = data.aws_caller_identity.current.account_id
  })

  tags = {
    Name = "rds-key"
  }
}

resource "aws_kms_alias" "db_alias" {
  name          = "alias/db-key"
  target_key_id = aws_kms_key.db_key.key_id
}

resource "aws_kms_key" "s3_key" {
  description             = "KMS key for S3 bucket"
  enable_key_rotation     = true
  deletion_window_in_days = 7

  tags = {
    Name = "s3-key"
  }
}

resource "aws_kms_alias" "s3_alias" {
  name          = "alias/s3-key"
  target_key_id = aws_kms_key.s3_key.key_id
}

resource "aws_kms_key" "secrets_manager_key" {
  description             = "KMS key for Secrets Manager"
  enable_key_rotation     = true
  deletion_window_in_days = 7

  tags = {
    Name = "secrets-manager-key"
  }
}

resource "aws_kms_alias" "secrets-manager_alias" {
  name          = "alias/secrets-manager-key"
  target_key_id = aws_kms_key.secrets_manager_key.key_id
}