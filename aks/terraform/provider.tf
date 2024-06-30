provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks" {
  name     = "aks-resource-group"
  location = "East US"
}
