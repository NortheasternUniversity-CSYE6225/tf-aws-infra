# Create an IAM policy that allows EC2 instances to upload and delete objects in the S3 bucket.
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
          "s3:DeleteObject"
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
