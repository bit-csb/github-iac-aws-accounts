provider "aws" {
  region  = "us-east-1"
  # profile = var.profilename
}

provider "aws" {
  alias   = "europe"
  region  = "eu-central-1"
  # profile = var.profilename
}

provider "azuread" {
}