output "microsite_bucket" {
  description = "The S3 bucket used for microsite content"
  value       = aws_s3_bucket.microsite_bucket
}

output "microsite_bucket_id" {
  description = "The ID of the S3 bucket used for microsite content"
  value       = aws_s3_bucket.microsite_bucket.id
}

output "microsite_bucket_arn" {
  description = "The ARN of the S3 bucket used for microsite content"
  value       = aws_s3_bucket.microsite_bucket.arn
}

output "cloudtrail_logs_bucket" {
  description = "The S3 bucket used for microsite content"
  value       = aws_s3_bucket.cloudtrail_logs_bucket
}

output "cloudtrail_logs_bucket_id" {
  description = "The ID of the S3 bucket used for access logs"
  value       = aws_s3_bucket.cloudtrail_logs_bucket.id
}

output "cloudtrail_logs_bucket_arn" {
  description = "The ARN of the S3 bucket used for access logs"
  value       = aws_s3_bucket.cloudtrail_logs_bucket.arn
}

output "cloudtrail_logs_bucket_policy_id" {
  description = "ID of the CloudTrail logs bucket policy"
  value       = aws_s3_bucket_policy.cloudtrail_logs.id
}