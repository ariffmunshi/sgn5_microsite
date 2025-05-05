provider "aws" {
  region  = "ap-southeast-1"
  profile = "sgn-microsite"

  # No need to assume role when running in GitLab CI
  assume_role {
    role_arn    = "arn:aws:iam::211125747707:role/rol-sgathome_tf"
    session_name = "terraform-local"
  }
}