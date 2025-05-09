output "key_id" {
  description = "The ID of the KMS key used for CloudWatch Logs encryption"
  value       = aws_kms_key.cloudwatch.id
}

output "key_arn" {
  description = "The ARN of the KMS key used for CloudWatch Logs encryption"
  value       = aws_kms_key.cloudwatch.arn
}

output "key_alias" {
  description = "The alias of the KMS key used for CloudWatch Logs encryption"
  value       = aws_kms_alias.cloudwatch.name
}