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