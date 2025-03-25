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