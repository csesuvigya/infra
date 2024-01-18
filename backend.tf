terraform {
  backend "s3" {
    bucket         = "suvi-tf-state"
    key            = "statefile/terraform.tfstate"
    region         = "us-east-1"
    profile        = "suvi-aws1"
  }
}