# ------------------------------------------------------------------------------
# Reference existing AWS resources
# ------------------------------------------------------------------------------
data "aws_cloudfront_distribution" "existing_cloudfront_distribution" {
	id = var.existing_cloudfront_distribution_id
}

data "aws_s3_bucket" "existing_microsite_access_logs_bucket" {
  bucket = var.existing_microsite_access_logs_bucket_name
}