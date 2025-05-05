provider "aws" {
  region  = "ap-southeast-1"

  # Deployed locally
  profile = "sgn-microsite"

  assume_role {
    role_arn    = "arn:aws:iam::211125747707:role/rol-sgathome_tf"
    session_name = "terraform-local"
  }
}