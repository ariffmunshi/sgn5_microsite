# General configuration
locals {
	project_name = "microsite"
	env          = "prod"
	region       = "ap-southeast-1"
}

# ------------------------------------------------------------------------------
# Storage - S3 Bucket for Microsite Hosting
# ------------------------------------------------------------------------------
module "microsite_s3" {
	source = "../../modules/storage/s3"

	project_name					= local.project_name
	env          					= local.env
	
	cloudfront_distribution_arn	= data.aws_cloudfront_distribution.existing_cloudfront_distribution.arn
}

# ------------------------------------------------------------------------------
# Monitoring - CloudWatch & CloudTrail
# ------------------------------------------------------------------------------
module "microsite_monitoring" {
  source = "../../modules/monitoring/cloudwatch"

  project_name = local.project_name
  env          = local.env
  region       = local.region

  # Connect to the S3 bucket
  s3_bucket_id         = module.microsite_s3.microsite_bucket_id
  cloudfront_distro_id = data.aws_cloudfront_distribution.existing_cloudfront_distribution.id

  # Optional: Configure custom alarm thresholds
}

module "microsite_cloudtrail" {
  source = "../../modules/monitoring/cloudtrail"

  project_name      = local.project_name
  env               = local.env
  microsite_bucket_id      = module.microsite_s3.microsite_bucket_id
  logs_bucket_name  = module.microsite_s3.cloudtrail_logs_bucket_id
  bucket_policy_id  = module.microsite_s3.cloudtrail_logs_bucket_policy_id

  # Only include this if you want to override the default value
  # log_retention_days = 90
}