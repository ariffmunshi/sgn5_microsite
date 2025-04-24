output "distribution_id" {
	value = aws_cloudfront_distribution.microsite.id
}

output "distribution_domain_name" {
	value = aws_cloudfront_distribution.microsite.domain_name
}

output "distribution_arn" {
	value       = aws_cloudfront_distribution.microsite.arn
	description = "ARN of the CloudFront distribution"
}

output "distribution_oai_iam_arn" {
	description = "IAM ARN of the CloudFront Origin Access Identity"
	value       = aws_cloudfront_origin_access_identity.microsite.iam_arn
}