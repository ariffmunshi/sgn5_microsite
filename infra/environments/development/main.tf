# General configuration
locals {
  project_name = "microsite"
  env          = "dev"
  region       = "ap-southeast-1"
}

# ------------------------------------------------------------------------------
# Storage - S3 Buckets for Microsite Hosting
# ------------------------------------------------------------------------------
module "microsite_s3" {
  source = "../../modules/storage/s3/microsite"

  project_name = local.project_name
  env          = local.env

  # Cloudfront variables 
  cloudfront_distribution_arn	= data.aws_cloudfront_distribution.existing_cloudfront_distribution.arn

  # S3 access logs variables
  access_logs_prefix = local.env
  access_logs_bucket = data.aws_s3_bucket.existing_microsite_access_logs_bucket.bucket
}

module "microsite_s3_cloudtrail_logs" {
  source = "../../modules/storage/s3/cloudtrail_logs"

  project_name = local.project_name
  env          = local.env

  # S3 access logs variables
  access_logs_prefix = local.env
  access_logs_bucket = data.aws_s3_bucket.existing_microsite_access_logs_bucket.bucket
}

# ------------------------------------------------------------------------------
# Monitoring - CloudWatch & CloudTrail
# ------------------------------------------------------------------------------
module "microsite_monitoring" {
  source = "../../modules/monitoring/cloudwatch"

  project_name = local.project_name
  env          = local.env
  region       = local.region

  # S3 variables
  s3_bucket_id         = module.microsite_s3.microsite_bucket_id
  cloudfront_distro_id = data.aws_cloudfront_distribution.existing_cloudfront_distribution.id

  # Optional: Configure custom alarm thresholds
}

module "microsite_cloudtrail" {
  source = "../../modules/monitoring/cloudtrail"

  project_name      = local.project_name
  env               = local.env

  # S3 bucket variables
  microsite_bucket_id      = module.microsite_s3.microsite_bucket_id
  logs_bucket_name  = module.microsite_s3_cloudtrail_logs.cloudtrail_logs_bucket.bucket
  bucket_policy_id  = module.microsite_s3_cloudtrail_logs.cloudtrail_logs_bucket_policy_id
  
  # Only include this if you want to override the default value
  # log_retention_days = 90

  # KMS variables
  cloudwatch_kms_key_id = module.kms.key_arn
}

# ------------------------------------------------------------------------------
# Security - KMS for CloudWatch Logs Encryption
# ------------------------------------------------------------------------------
module "kms" {
  source = "../../modules/security/kms"

  project_name = local.project_name
  env          = local.env
  region       = local.region
}