variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "env" {
  description = "Environment (dev, test, prod)"
  type        = string
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