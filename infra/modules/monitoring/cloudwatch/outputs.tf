output "dashboard_name" {
	description = "Name of the created CloudWatch dashboard"
	value       = aws_cloudwatch_dashboard.microsite.dashboard_name
}

output "dashboard_arn" {
	description = "ARN of the created CloudWatch dashboard"
	value       = aws_cloudwatch_dashboard.microsite.dashboard_arn
}

# CloudFront alarm outputs
output "cloudfront_alarms" {
	description = "Map of CloudFront alarms and their ARNs"
	value = {
		requests = {
		name = aws_cloudwatch_metric_alarm.cloudfront_requests.alarm_name
		arn  = aws_cloudwatch_metric_alarm.cloudfront_requests.arn
		}
		errors_4xx = {
		name = aws_cloudwatch_metric_alarm.cloudfront_4xx_errors.alarm_name
		arn  = aws_cloudwatch_metric_alarm.cloudfront_4xx_errors.arn
		}
		errors_5xx = {
		name = aws_cloudwatch_metric_alarm.cloudfront_5xx_errors.alarm_name
		arn  = aws_cloudwatch_metric_alarm.cloudfront_5xx_errors.arn
		}
		latency = {
		name = aws_cloudwatch_metric_alarm.cloudfront_latency.alarm_name
		arn  = aws_cloudwatch_metric_alarm.cloudfront_latency.arn
		}
	}
}

# S3 alarm outputs
output "s3_alarms" {
	description = "Map of S3 alarms and their ARNs"
	value = {
		requests = {
		name = aws_cloudwatch_metric_alarm.s3_total_requests.alarm_name
		arn  = aws_cloudwatch_metric_alarm.s3_total_requests.arn
		}
		errors = {
		name = aws_cloudwatch_metric_alarm.s3_errors.alarm_name
		arn  = aws_cloudwatch_metric_alarm.s3_errors.arn
		}
		latency = {
		name = aws_cloudwatch_metric_alarm.s3_latency.alarm_name
		arn  = aws_cloudwatch_metric_alarm.s3_latency.arn
		}
	}
}