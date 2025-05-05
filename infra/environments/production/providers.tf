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
    key            = "environments/prod/terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "microsite-terraform-lock"
    profile        = "sgn-microsite"
  }
}

provider "aws" {
  region  = "ap-southeast-1"
  profile = "sgn-microsite"

  assume_role {
    role_arn    = "arn:aws:iam::211125747707:role/rol-sgathome_tf"
    session_name = "terraform-local-development"
  }
}