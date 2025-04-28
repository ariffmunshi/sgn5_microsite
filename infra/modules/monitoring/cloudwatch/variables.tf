variable "project_name" {
	description = "Name of the project"
	type        = string
}

variable "env" {
	description = "Environment (dev, stage, prod)"
	type        = string
}

variable "region" {
	description = "AWS region"
	type        = string
	default     = "ap-southeast-1"
}

variable "s3_bucket_id" {
	description = "ID of the S3 bucket to monitor"
	type        = string
}

variable "cloudfront_distro_id" {
	description = "ID of the CloudFront distribution to monitor"
	type        = string
}

# Alarm thresholds
variable "max_requests_threshold" {
	type        = number
	description = "Maximum number of requests per period before alerting"
	default     = 10000
}

variable "error_rate_threshold" {
	description = "Threshold percentage for error rate alarms"
	type        = number
	default     = 5
}

variable "latency_threshold_ms" {
	description = "Threshold in milliseconds for latency alarms"
	type        = number
	default     = 3000
}

variable "evaluation_periods" {
	description = "Number of periods over which data is compared to the threshold"
	type        = number
	default     = 1
}

variable "period" {
	description = "Period in seconds over which the statistic is applied"
	type        = number
	default     = 300  # 5 minutes
}