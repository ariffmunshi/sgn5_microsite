resource "aws_cloudtrail" "microsite_trail" {
  name                          = "${var.project_name}-${var.env}-s3-cloudtrail"
  s3_bucket_name                = var.logs_bucket_name
  s3_key_prefix                 = "cloudtrail"
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = var.enable_log_file_validation

  # CloudWatch Logs integration
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail_cloudwatch_role.arn

  depends_on = [var.bucket_policy_id]

  # Only log S3 data events for the specified buckets
  event_selector {
    read_write_type           = "All"
    include_management_events = false

    data_resource {
	  type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::${var.microsite_bucket_id}/"]
    }
  }

  tags = {
    Name        = "${var.project_name}-${var.env}-s3-cloudtrail"
    Environment = var.env
  }
}