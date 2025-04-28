locals {
	name_prefix = "${var.project_name}-${var.env}"
}

resource "aws_cloudwatch_dashboard" "microsite" {
	dashboard_name = "${local.name_prefix}-dashboard"
	
	dashboard_body = jsonencode({
		widgets = [
		# CloudFront Metrics
		{
			type   = "text"
			x      = 0
			y      = 0
			width  = 24
			height = 1
			properties = {
			markdown = "# CloudFront Metrics"
			}
		},
		{
			type   = "metric"
			x      = 0
			y      = 1
			width  = 12
			height = 6
			properties = {
			metrics = [
				["AWS/CloudFront", "Requests", "DistributionId", var.cloudfront_distro_id],
			]
			period = 300
			stat   = "Sum"
			region = "us-east-1" # CloudFront metrics are in us-east-1
			title  = "CloudFront Requests"
			}
		},
		{
			type   = "metric"
			x      = 12
			y      = 1
			width  = 12
			height = 6
			properties = {
			metrics = [
				["AWS/CloudFront", "4xxErrorRate", "DistributionId", var.cloudfront_distro_id],
				["AWS/CloudFront", "5xxErrorRate", "DistributionId", var.cloudfront_distro_id]
			]
			period = 300
			stat   = "Average"
			region = "us-east-1"
			title  = "CloudFront Error Rates"
			annotations = {
				horizontal: [
				{
					value: 5,
					label: "4xx Error Threshold",
					color: "#ff9900"
				},
				{
					value: 1,
					label: "5xx Error Threshold",
					color: "#d13212"
				}
				]
			}
			}
		},
		{
			type   = "metric"
			x      = 0
			y      = 7
			width  = 12
			height = 6
			properties = {
			metrics = [
				["AWS/CloudFront", "TotalErrorRate", "DistributionId", var.cloudfront_distro_id]
			]
			period = 300
			stat   = "Average"
			region = "us-east-1"
			title  = "CloudFront Total Error Rate"
			}
		},
		{
			type   = "metric"
			x      = 12
			y      = 7
			width  = 12
			height = 6
			properties = {
			metrics = [
				["AWS/CloudFront", "OriginLatency", "DistributionId", var.cloudfront_distro_id]
			]
			period = 300
			stat   = "Average"
			region = "us-east-1"
			title  = "CloudFront Origin Latency"
			annotations = {
				horizontal: [
				{
					value: 1000,
					label: "Latency Threshold (ms)",
					color: "#d13212"
				}
				]
			}
			}
		},
		
		# S3 Metrics
		{
			type   = "text"
			x      = 0
			y      = 13
			width  = 24
			height = 1
			properties = {
			markdown = "# S3 Bucket Metrics"
			}
		},
		{
			type   = "metric"
			x      = 0
			y      = 14
			width  = 12
			height = 6
			properties = {
			metrics = [
				["AWS/S3", "AllRequests", "BucketName", var.s3_bucket_id]
			]
			period = 300
			stat   = "Sum"
			region = var.region
			title  = "S3 Total Requests"
			annotations = {
				horizontal: [
				{
					value: 1000,
					label: "Request Threshold",
					color: "#ff9900"
				}
				]
			}
			}
		},
		{
			type   = "metric"
			x      = 12
			y      = 14
			width  = 12
			height = 6
			properties = {
			metrics = [
				["AWS/S3", "5xxErrors", "BucketName", var.s3_bucket_id]
			]
			period = 300
			stat   = "Sum"
			region = var.region
			title  = "S3 Errors"
			annotations = {
				horizontal: [
				{
					value: 50,
					label: "Error Threshold",
					color: "#d13212"
				}
				]
			}
			}
		},
		{
			type   = "metric"
			x      = 0
			y      = 20
			width  = 12
			height = 6
			properties = {
			metrics = [
				["AWS/S3", "BucketSizeBytes", "BucketName", var.s3_bucket_id, "StorageType", "StandardStorage"]
			]
			period = 86400
			stat   = "Average"
			region = var.region
			title  = "S3 Bucket Size"
			}
		},
		{
			type   = "metric"
			x      = 12
			y      = 20
			width  = 12
			height = 6
			properties = {
			metrics = [
				["AWS/S3", "FirstByteLatency", "BucketName", var.s3_bucket_id]
			]
			period = 300
			stat   = "Average"
			region = var.region
			title  = "S3 First Byte Latency"
			annotations = {
				horizontal: [
				{
					value: 200,
					label: "Latency Threshold (ms)",
					color: "#d13212"
				}
				]
			}
			}
		}
		]
	})
}

# CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "cloudfront_requests" {
	alarm_name          = "${local.name_prefix}-cloudfront-requests"
	comparison_operator = "GreaterThanThreshold"
	evaluation_periods  = var.evaluation_periods
	metric_name         = "Requests"
	namespace           = "AWS/CloudFront"
	period              = var.period
	statistic           = "Sum"
	threshold           = var.max_requests_threshold  # Define in variables
	alarm_description   = "Monitor total CloudFront requests"
	treat_missing_data  = "notBreaching"
	
	dimensions = {
		DistributionId = var.cloudfront_distro_id
		Region         = "Global"
	}
}

resource "aws_cloudwatch_metric_alarm" "cloudfront_4xx_errors" {
	alarm_name          = "${local.name_prefix}-cloudfront-4xx-errors"
	comparison_operator = "GreaterThanThreshold"
	evaluation_periods  = var.evaluation_periods
	metric_name         = "4xxErrorRate"
	namespace           = "AWS/CloudFront"
	period              = var.period
	statistic           = "Average"
	threshold           = 5  # 5% error rate
	alarm_description   = "This alarm monitors CloudFront 4xx error rate"
	treat_missing_data = "notBreaching"
	
	dimensions = {
		DistributionId = var.cloudfront_distro_id
		Region         = "Global"
	}
}

resource "aws_cloudwatch_metric_alarm" "cloudfront_5xx_errors" {
	alarm_name          = "${local.name_prefix}-cloudfront-5xx-errors"
	comparison_operator = "GreaterThanThreshold"
	evaluation_periods  = var.evaluation_periods
	metric_name         = "5xxErrorRate"
	namespace           = "AWS/CloudFront"
	period              = var.period
	statistic           = "Average"
	threshold           = 1  # 1% error rate
	alarm_description   = "This alarm monitors CloudFront 5xx error rate"
	treat_missing_data = "notBreaching"
	
	dimensions = {
		DistributionId = var.cloudfront_distro_id
		Region         = "Global"
	}
}

resource "aws_cloudwatch_metric_alarm" "cloudfront_latency" {
	alarm_name          = "${local.name_prefix}-cloudfront-latency"
	comparison_operator = "GreaterThanThreshold"
	evaluation_periods  = var.evaluation_periods
	metric_name         = "TotalErrorRate"
	namespace           = "AWS/CloudFront"
	period              = var.period
	statistic           = "Average"
	threshold           = 1000  # 1 second
	alarm_description   = "Alert when CloudFront latency exceeds 1 second"
	treat_missing_data = "notBreaching"
	
	dimensions = {
		DistributionId = var.cloudfront_distro_id
		Region         = "Global"
	}
}

# S3 Alarm
resource "aws_cloudwatch_metric_alarm" "s3_total_requests" {
	alarm_name          = "${local.name_prefix}-s3-requests"
	comparison_operator = "GreaterThanThreshold"
	evaluation_periods  = var.evaluation_periods
	metric_name         = "AllRequests"
	namespace           = "AWS/S3"
	period              = var.period
	statistic           = "Sum"
	threshold           = 1000
	alarm_description   = "Monitor total requests to S3 bucket"
	treat_missing_data = "notBreaching"
	
	dimensions = {
		BucketName = var.s3_bucket_id
	}
}

resource "aws_cloudwatch_metric_alarm" "s3_errors" {
	alarm_name          = "${local.name_prefix}-s3-errors"
	comparison_operator = "GreaterThanThreshold"
	evaluation_periods  = var.evaluation_periods
	metric_name         = "5xxErrors"
	namespace           = "AWS/S3"
	period              = var.period
	statistic           = "Sum"
	threshold           = 50
	alarm_description   = "Monitor S3 errors"
	treat_missing_data = "notBreaching"
	
	dimensions = {
		BucketName = var.s3_bucket_id
	}
}

resource "aws_cloudwatch_metric_alarm" "s3_latency" {
	alarm_name          = "${local.name_prefix}-s3-latency"
	comparison_operator = "GreaterThanThreshold"
	evaluation_periods  = var.evaluation_periods
	metric_name         = "FirstByteLatency"
	namespace           = "AWS/S3"
	period              = var.period
	statistic           = "Average"
	threshold           = 200
	alarm_description   = "Monitor S3 latency"
	treat_missing_data = "notBreaching"
	
	dimensions = {
		BucketName = var.s3_bucket_id
	}
}