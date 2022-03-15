provider "aws" {
  region  = "us-east-1"
  profile = var.profilename
}

provider "aws" {
  alias   = "europe"
  region  = "eu-central-1"
  profile = var.profilename
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = var.subscription
  features {
  }
}

provider "azuread" {
}
