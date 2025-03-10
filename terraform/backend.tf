terraform {
  backend "s3" {
    bucket         = "staging-devsecops"   # Replace with your actual S3 bucket
    key            = "ec2/terraform.tfstate"         # Explicitly define the key
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
