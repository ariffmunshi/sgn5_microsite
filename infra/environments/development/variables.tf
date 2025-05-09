variable "existing_cloudfront_distribution_id" {
  description = "ID of the existing CloudFront distribution"
  type        = string
  default     = ""
}

variable "existing_microsite_access_logs_bucket_name" {
  description = "Name of the existing S3 bucket for microsite access logs"
  type        = string
  default     = ""
}