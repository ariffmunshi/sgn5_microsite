resource "aws_cloudfront_origin_access_identity" "microsite" {
	comment = "${var.project_name}-${var.env}-origin-access-identity"
}

resource "aws_cloudfront_distribution" "microsite" {
	origin {
		domain_name = var.s3_microsite_bucket.bucket_regional_domain_name
		origin_id   = "S3-${var.s3_microsite_bucket.id}"

		s3_origin_config {
			origin_access_identity = aws_cloudfront_origin_access_identity.microsite.cloudfront_access_identity_path
		}
	}

	enabled             = true
	is_ipv6_enabled     = true
	default_root_object = "index.html"

	default_cache_behavior {
		allowed_methods  = ["GET", "HEAD", "OPTIONS"]
		cached_methods   = ["GET", "HEAD"]
		target_origin_id = "S3-${var.s3_microsite_bucket.id}"

		cache_policy_id = data.aws_cloudfront_cache_policy.caching_optimized.id

		viewer_protocol_policy = "redirect-to-https"
	}

	price_class = "PriceClass_All"

	restrictions {
		geo_restriction {
		restriction_type = "none"
		}
	}

	viewer_certificate {
		cloudfront_default_certificate = true
	}

	tags = {
		Name        = "${var.project_name}-${var.env}-distribution"
		Environment = var.env
	}
}
