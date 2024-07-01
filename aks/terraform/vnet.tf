################################################################################
# VNET configuration
################################################################################
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project_name}-aks-vnet"
  address_space       = var.vnet_space
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  tags                = var.tags_base
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "${var.project_name}-aks-subnet"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.aks_subnet
}

resource "azurerm_subnet" "appgw_subnet" {
  name                 = "${var.project_name}-appgw-subnet"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.appgw_subnet
}

resource "azurerm_public_ip" "appgw_public_ip" {
  name                = "${var.project_name}-appgw-public-ip"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
