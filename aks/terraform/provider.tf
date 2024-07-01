provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "cloudsetupstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
