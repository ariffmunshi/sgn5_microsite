# Cloudtrail
output "cloudtrail_id" {
  description = "ID of the CloudTrail trail"
  value       = aws_cloudtrail.microsite_trail.id
}

output "cloudtrail_arn" {
  description = "ARN of the CloudTrail trail"
  value       = aws_cloudtrail.microsite_trail.arn
}

# Cloudwatch Log Group
output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch Logs group for CloudTrail"
  value       = aws_cloudwatch_log_group.cloudtrail.name
}

output "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch Logs group for CloudTrail"
  value       = aws_cloudwatch_log_group.cloudtrail.arn
}

output "cloudtrail_cloudwatch_role_name" {
  description = "Name of the IAM role used by CloudTrail to write to CloudWatch Logs"
  value       = aws_iam_role.cloudtrail_cloudwatch_role.name
}

output "cloudtrail_cloudwatch_role_arn" {
  description = "ARN of the IAM role used by CloudTrail to write to CloudWatch Logs"
  value       = aws_iam_role.cloudtrail_cloudwatch_role.arn
}

output "s3_log_prefix" {
  description = "S3 prefix where CloudTrail logs are delivered"
  value       = "${var.logs_bucket_name}/${aws_cloudtrail.microsite_trail.s3_key_prefix}"
}