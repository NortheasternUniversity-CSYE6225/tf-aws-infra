# Create IAM role for EC2 instance to access S3 bucket.
resource "aws_iam_role" "ec2_webapp_role" {
  name = "ec2-webapp-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "webapp_s3_attachment" {
  role       = aws_iam_role.ec2_webapp_role.name
  policy_arn = aws_iam_policy.webapp_s3_policy.arn
}

# Attach the CloudWatch agent policy to the role
resource "aws_iam_role_policy_attachment" "cloudwatch_agent_attach" {
  role       = aws_iam_role.ec2_webapp_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Attach the CloudWatch metrics policy to the role
resource "aws_iam_role_policy_attachment" "webapp_cloudwatch_metrics" {
  role       = aws_iam_role.ec2_webapp_role.name
  policy_arn = aws_iam_policy.webapp_cloudwatch_metrics.arn
}

# Create an instance profile
resource "aws_iam_instance_profile" "ec2_webapp_profile" {
  name = "ec2-webapp-profile"
  role = aws_iam_role.ec2_webapp_role.name
}

# Attach the Secrets Manager policy to the role
resource "aws_iam_role_policy_attachment" "secretsmanager_policy" {
  role       = aws_iam_role.ec2_webapp_role.name
  policy_arn = aws_iam_policy.secretsmanager_policy.arn
}

# Attach the KMS key access policy to the role
resource "aws_iam_role_policy_attachment" "ec2_kms_key_access_policy" {
  role       = aws_iam_role.ec2_webapp_role.name
  policy_arn = aws_iam_policy.ec2_kms_key_access.arn
}

# Attach the S3 KMS key access policy to the role
resource "aws_iam_role_policy_attachment" "s3_kms_key_access_policy" {
  role       = aws_iam_role.ec2_webapp_role.name
  policy_arn = aws_iam_policy.s3_kms_key_access.arn
}
