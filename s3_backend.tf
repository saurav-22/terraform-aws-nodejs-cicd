# S3 Backend
terraform {
  backend "s3" {
    bucket = "saurav-tf-bucket"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}