provider "aws" {
  region     = "ap-south-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

# resource "aws_instance" "my_ec2" {
#   ami           = "ami-0f535a71b34f2d44a"
#   instance_type = "t3.micro"
# }

# This create s3 bucket in aws
resource "aws_s3_bucket" "staticweb" {
  bucket = "staticwebhoisting"

  tags = {
    Name = "My bucket"
  }
}

# This will enables static website hosting
resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.staticweb.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# This is used to upload files (objects) into the S3 bucket.
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.staticweb.id
  key    = "index.html"
  source = "website/index.html"
}