terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "microsite-terraform-state"
    key            = "environments/dev/terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "microsite-terraform-lock"
    
	# Only needed for local development
	# profile        = "sgn-microsite"
  }
}


provider "aws" {
  region  = "ap-southeast-1"

	# Only needed for local development
#   profile = "sgn-microsite"

#   assume_role {
#     role_arn     = "arn:aws:iam::211125747707:role/rol-sgathome_tf"
#     session_name = "terraform-local-development"
#   }
}