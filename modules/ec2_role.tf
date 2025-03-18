# Create IAM role for EC2 instance to access S3 bucket.
resource "aws_iam_role" "webapp_s3_role" {
  name = "webapp-ec2-s3-role"

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
  role       = aws_iam_role.webapp_s3_role.name
  policy_arn = aws_iam_policy.webapp_s3_policy.arn
}

# Create an instance profile
resource "aws_iam_instance_profile" "webapp_s3_profile" {
  name = "webapp-ec2-s3-profile"
  role = aws_iam_role.webapp_s3_role.name
}