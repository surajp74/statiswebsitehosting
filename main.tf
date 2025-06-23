provider "aws" {
  region = "ap-south-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0f535a71b34f2d44a"
  instance_type = "t3.micro"
}