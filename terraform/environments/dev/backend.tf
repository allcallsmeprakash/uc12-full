terraform {
  backend "s3" {
    bucket = "training-usecases"
    key    = "uc12/terraform.tfstate"
    region = "us-east-1"
  }
}
