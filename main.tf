module "aws_resources" {
  source   = "./aws"
  providers = {
    aws = aws.aws
  }
}


module "azure_resources" {
  source   = "./azure"
  providers = {
    azurerm = azurerm.azure
  }

  prefix = var.prefix
  location = var.location
}
