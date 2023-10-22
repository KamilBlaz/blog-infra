resource "aws_s3_bucket" "static" {
  bucket_prefix = "${local.stack_name}-static-"

  force_destroy = true

  tags = local.common_tags
}

resource "aws_s3_bucket_acl" "static" {
  bucket = aws_s3_bucket.static.id

  acl = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "static" {
  bucket = aws_s3_bucket.static.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "static" {
  bucket = aws_s3_bucket.static.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]

    allowed_origins = distinct([
      "https://${var.domain}",
      "https://${local.domains.backend}",
    ])

    expose_headers  = ["ETag", "Content-Type", "Content-Length"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_policy" "static" {
  bucket = aws_s3_bucket.static.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "cloudfront.amazonaws.com"
      }
      Action   = "s3:GetObject"
      Resource = "${aws_s3_bucket.static.arn}/*"
      Condition : {
        StringEquals : {
          "AWS:SourceArn" : module.cloudfront_cdn.cloudfront_arn
        }
      }
    }]
  })
}

resource "aws_s3_bucket_ownership_controls" "static" {
  bucket = aws_s3_bucket.static.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
