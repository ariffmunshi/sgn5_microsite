# ------------------------------------------------------------------------------
# Reference existing AWS resources
# ------------------------------------------------------------------------------
data "aws_cloudfront_distribution" "existing_cloudfront_distribution" {
	id = var.existing_cloudfront_distribution_id
}