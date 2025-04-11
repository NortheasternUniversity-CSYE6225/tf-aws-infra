resource "aws_kms_key" "ec2_key" {
  description             = "KMS key for EC2"
  enable_key_rotation     = true
  deletion_window_in_days = 7
  policy                  = data.aws_iam_policy_document.ec2_kms_policy.json
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

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowRootAccess",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*",
        Resource = "*"
      },
      {
        Sid    = "AllowRDS",
        Effect = "Allow",
        Principal = {
          Service = "rds.amazonaws.com"
        },
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        Resource = "*"
      }
    ]
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

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid : "AllowRootAccess",
        Effect : "Allow",
        Principal : {
          AWS : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action : "kms:*",
        Resource : "*"
      },
      {
        Sid : "AllowEC2WebAppRole",
        Effect : "Allow",
        Principal : {
          AWS : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ec2-webapp-role"
        },
        Action : [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:GenerateDataKey",
          "kms:GenerateDataKeyWithoutPlaintext",
          "kms:DescribeKey"
        ],
        Resource : "*"
      }
    ]
  })

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