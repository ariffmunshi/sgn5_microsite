variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "env" {
  description = "Environment (dev, test, prod)"
  type        = string
}

variable "cloudfront_distribution_arn" {
  description = "ARN of the CloudFront distribution that will access this bucket"
  type        = string
  default     = ""
}

variable "cloudfront_oai_iam_arn" {
  description = "IAM ARN of the CloudFront Origin Access Identity"
  type        = string
  default     = ""
}

variable "cloudfront_depends_on" {
  description = "Used to create explicit dependency on CloudFront"
  type        = any
  default     = null
}

variable "access_logs_prefix" {
  description = "Prefix for S3 access logs directory structure"
  type        = string
  default     = ""
}

variable "access_logs_bucket" {
  description = "Bucket to store S3 access logs"
  type        = string
  default     = ""
}

variable "log_retention_days" {
  description = "Number of days to retain CloudTrail logs"
  type        = number
  default     = 90
}