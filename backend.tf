terraform {
  backend "s3" {
    bucket = "terrabucketforstate"
    region = "us-east-1"
    key = "dev/terraform.tfstate"
    dynamodb_table = "tf-lock-table"
    
  }
}