# Microsite URL
output "microsite_url" {
	description = "URL of the microsite"
	value       = data.aws_cloudfront_distribution.existing_cloudfront_distribution.aliases
}

# Microsite S3 Bucket
output "microsite_bucket_name" {
	description = "Name of the S3 bucket hosting the microsite content"
	value       = module.microsite_s3.microsite_bucket_id
}

output "microsite_bucket_arn" {
	description = "ARN of the S3 bucket hosting the microsite content"
	value       = module.microsite_s3.microsite_bucket_arn
}

# CloudFront
output "cloudfront_distribution_id" {
	description = "ID of the CloudFront distribution"
	value       = data.aws_cloudfront_distribution.existing_cloudfront_distribution.id
}

output "cloudfront_domain_name" {
	description = "Domain name of the CloudFront distribution"
	value       = data.aws_cloudfront_distribution.existing_cloudfront_distribution.domain_name
}

# Monitoring - CloudWatch
output "cloudwatch_dashboard_name" {
  description = "Name of the CloudWatch dashboard for the microsite"
  value       = module.microsite_monitoring.dashboard_name
}

output "cloudwatch_dashboard_arn" {
  description = "ARN of the CloudWatch dashboard"
  value       = module.microsite_monitoring.dashboard_arn
}

output "cloudfront_alarms" {
  description = "CloudFront monitoring alarms"
  value       = module.microsite_monitoring.cloudfront_alarms
}

output "s3_alarms" {
  description = "S3 bucket monitoring alarms"
  value       = module.microsite_monitoring.s3_alarms
}

# Monitoring - CloudTrail
output "cloudtrail_id" {
  description = "ID of the CloudTrail trail"
  value       = module.microsite_cloudtrail.cloudtrail_id
}

output "cloudtrail_arn" {
  description = "ARN of the CloudTrail trail"
  value       = module.microsite_cloudtrail.cloudtrail_arn
}

output "cloudtrail_log_group_name" {
  description = "Name of the CloudWatch Logs group for CloudTrail"
  value       = module.microsite_cloudtrail.cloudwatch_log_group_name
}

output "cloudtrail_log_group_arn" {
  description = "ARN of the CloudWatch Logs group for CloudTrail"
  value       = module.microsite_cloudtrail.cloudwatch_log_group_arn
}

output "cloudtrail_cloudwatch_role_name" {
  description = "Name of the IAM role used by CloudTrail to write to CloudWatch Logs"
  value       = module.microsite_cloudtrail.cloudtrail_cloudwatch_role_name
}

output "cloudtrail_cloudwatch_role_arn" {
  description = "ARN of the IAM role used by CloudTrail to write to CloudWatch Logs"
  value       = module.microsite_cloudtrail.cloudtrail_cloudwatch_role_arn
}

output "cloudtrail_s3_log_prefix" {
  description = "S3 prefix where CloudTrail logs are delivered"
  value       = module.microsite_cloudtrail.s3_log_prefix
}

# KMS Keys
output "cloudwatch_kms_key_id" {
  description = "ID of the KMS key used for CloudWatch Logs encryption"
  value       = module.kms.key_id
}

output "cloudwatch_kms_key_arn" {
  description = "ARN of the KMS key used for CloudWatch Logs encryption"
  value       = module.kms.key_arn
}