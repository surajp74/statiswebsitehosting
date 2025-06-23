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
  bucket = "staticwebhoistingdemo"

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
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.staticweb.id
  key          = "index.html"
  source       = "website/index.html"
  content_type = "text/html"

  # source_hash = filemd5("website/index.html") // filemd5() recalculates the hash of the file every time it's changed — forcing Terraform to re-upload.
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.staticweb.id
  key = "error.html"
  source = "website/error.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.staticweb.id

  block_public_acls       =false
  block_public_policy     =false
  ignore_public_acls      =false
  restrict_public_buckets =false
}

resource "aws_s3_bucket_policy" "allow_public_read" {
  bucket = aws_s3_bucket.staticweb.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = ["s3:GetObject"],
        Resource  = "${aws_s3_bucket.staticweb.arn}/*"
      }
    ]
  })
}