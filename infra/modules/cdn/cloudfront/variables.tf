variable "project_name" {
	description = "Name of the project"
	type        = string
}

variable "env" {
	description = "Environment (dev, test, prod)"
	type        = string
}

variable "s3_microsite_bucket" {
	description = "The S3 bucket object containing microsite content"
	type        = any
}
