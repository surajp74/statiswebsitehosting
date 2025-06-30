provider "aws" {
  region = "ap-south-1"
  alias  = "aws"
}

provider "azurerm" {
  alias = "azure"
  features {}
}

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}