resource "aws_s3_bucket" "microsite_bucket" {
  bucket        = "${var.project_name}-${var.env}-website"
  force_destroy = true

  tags = {
    Name        = "${var.project_name}-${var.env}-website"
    Environment = var.env
  }
}

resource "aws_s3_bucket_versioning" "microsite" {
  bucket = aws_s3_bucket.microsite_bucket.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "microsite" {
  bucket = aws_s3_bucket.microsite_bucket.bucket

  target_bucket = var.access_logs_bucket
  target_prefix = "${var.access_logs_prefix}/microsite-bucket/"
}

resource "aws_s3_bucket_public_access_block" "microsite" {
  bucket = aws_s3_bucket.microsite_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "microsite" {
  bucket = aws_s3_bucket.microsite_bucket.id

  # Use a conditional policy document
  policy = var.cloudfront_oai_iam_arn != "" ? jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = var.cloudfront_oai_iam_arn
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.microsite_bucket.arn}/*"
      },
	  {
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.microsite_bucket.arn,
          "${aws_s3_bucket.microsite_bucket.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
    }) : var.cloudfront_distribution_arn != "" ? jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.microsite_bucket.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = var.cloudfront_distribution_arn
          }
        }
      },
	  {
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.microsite_bucket.arn,
          "${aws_s3_bucket.microsite_bucket.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
    }) : jsonencode({
    Version   = "2012-10-17"
    Statement = [
		{
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.microsite_bucket.arn,
          "${aws_s3_bucket.microsite_bucket.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
	] 
  })

  # Make this depend on CloudFront creation explicitly
  depends_on = [var.cloudfront_depends_on]
}
