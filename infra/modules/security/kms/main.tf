resource "aws_kms_key" "cloudwatch" {
  description             = "KMS key for CloudWatch logs encryption - ${var.project_name}-${var.env}"
  key_usage               = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled              = true  
  enable_key_rotation     = true
  multi_region            = false
  deletion_window_in_days = var.key_deletion_window_days
  policy                  = data.aws_iam_policy_document.cloudwatch_kms_policy.json
  
  tags = {
    Name        = "${var.project_name}-${var.env}-cloudwatch-logs-key"
    Environment = var.env
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_kms_alias" "cloudwatch" {
  name          = "alias/${var.project_name}-${var.env}-cloudwatch-logs"
  target_key_id = aws_kms_key.cloudwatch.id
}