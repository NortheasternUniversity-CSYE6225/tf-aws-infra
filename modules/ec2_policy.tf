# Create an IAM policy that allows EC2 instances to upload and delete objects in the S3 bucket
resource "aws_iam_policy" "webapp_s3_policy" {
  name        = "webapp-s3-policy"
  description = "Allows EC2 instance to upload and delete objects in the S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:GetObject",
          "s3:HeadObject"
        ]
        Resource = "arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = "arn:aws:s3:::${aws_s3_bucket.bucket.id}"
      }
    ]
  })
}

# Create an IAM policy that allows EC2 instances to publish custom CloudWatch metrics
resource "aws_iam_policy" "webapp_cloudwatch_metrics" {
  name = "webapp-cloudwatch-metrics-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "cloudwatch:PutMetricData",
          "cloudwatch:ListMetrics",
          "cloudwatch:GetMetricData",
          "cloudwatch:GetMetricStatistics"
        ],
        Resource = "*"
      }
    ]
  })
}

# Create an IAM policy that allows EC2 instances to access Secrets Manager for RDS password
resource "aws_iam_policy" "secretsmanager_policy" {
  name = "secretsmanager-rds-password-access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = aws_secretsmanager_secret.secret_string.arn
      },
      {
        Effect = "Allow",
        Action = [
          "kms:Decrypt"
        ],
        Resource = aws_kms_key.secrets_manager_key.arn
      }
    ]
  })
}

# Create an IAM policy that allows EC2 instances to access KMS key for EBS encryption
resource "aws_iam_policy" "ec2_kms_key_access" {
  name = "ec2-kms-key-access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        Resource = aws_kms_key.ec2_key.arn
      }
    ]
  })
}