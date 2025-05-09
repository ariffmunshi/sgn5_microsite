variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "env" {
  description = "Environment (dev, test, prod)"
  type        = string
}

variable "microsite_bucket_id" {
  description = "ID of S3 bucket being tracked"
  type        = string
}

variable "logs_bucket_name" {
  description = "Name of the S3 bucket to store CloudTrail logs"
  type        = string
}

variable "enable_log_file_validation" {
  description = "Enable CloudTrail log file validation"
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "Number of days to retain CloudTrail logs in CloudWatch Logs"
  type        = number
  default     = 90  # Default 90 days, adjust as needed
}

variable "bucket_policy_id" {
  description = "ID of the S3 bucket policy to ensure it exists before creating CloudTrail"
  type        = string
}

variable "cloudwatch_kms_key_id" {
  description = "KMS key ARN to use for encrypting CloudWatch logs"
  type        = string
  default     = null 
}