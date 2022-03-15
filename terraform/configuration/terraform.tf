terraform {

  required_version = "~>1.1.2"

  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.70.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.92.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.15.0"
    }
  }
}
