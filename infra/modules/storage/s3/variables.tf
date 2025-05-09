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

variable "log_retention_days" {
  description = "Number of days to retain CloudTrail logs"
  type        = number
  default     = 90
}

variable "cloudtrail_bucket_name" {
  description = "Name for the CloudTrail log bucket (if not specified, a name will be generated)"
  type        = string
  default     = ""
}