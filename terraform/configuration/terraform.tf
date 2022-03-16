terraform {

  required_version = "~>1.1.2"

  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.99.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.19.0"
    }
  }
}
