data "aws_iam_policy_document" "cloudwatch_kms_policy" {
  # Enable root user permissions
  statement {
    sid    = "Enable Root User Permissions"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/rol-microsite_tf"
      ]
    }
    actions = [
      "kms:Describe*",
      "kms:Get*", 
      "kms:List*",
      "kms:RevokeGrant",
      "kms:CreateGrant",
      "kms:PutKeyPolicy",
	  "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]
  }

  # CloudWatch Logs permissions
  statement {
    sid    = "Allow CloudWatch Logs to encrypt logs"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["logs.${var.region}.amazonaws.com"]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]
    condition {
      test     = "ArnLike"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values   = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:*"]
    }
  }
}

data "aws_caller_identity" "current" {}