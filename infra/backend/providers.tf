provider "aws" {
  region  = "ap-southeast-1"
  profile = "sgn-aws" # This profile is used for local development

  assume_role {
    role_arn    = "arn:aws:iam::211125747707:role/rol-sgathome_tf"
    session_name = "terraform-local"
  }
}