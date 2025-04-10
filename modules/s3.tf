# Generate UUID for bucket name
resource "random_uuid" "bucket_uuid" {}

# Create S3 bucket
resource "aws_s3_bucket" "bucket" {
  bucket = random_uuid.bucket_uuid.result

  force_destroy = true

  tags = {
    Name = "csye6225-bucket"
  }
}

# The bucket is set to private.
resource "aws_s3_bucket_ownership_controls" "bucket_owner_control" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# The bucket's public access is blocked
resource "aws_s3_bucket_public_access_block" "bucket_block_public_access" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# The bucket is encrypted with AES256.
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_key.arn
    }
  }
}

# The bucket has a lifecycle rule to transition objects to the STANDARD_IA storage class after 30 days.
resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle_rule" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    id     = "transition-to-ia"
    status = "Enabled"

    transition {
      days          = var.s3_transition_days
      storage_class = var.s3_transition_storage_class
    }
  }
}

# Output the bucket name
output "s3_bucket_name" {
  value = aws_s3_bucket.bucket.id
}