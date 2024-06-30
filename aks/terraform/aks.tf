module "aks" {
  source  = "Azure/aks/azurerm"
  version = "5.0.0"

  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  dns_prefix          = "exampleaks"

  default_node_pool = {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  service_principal = {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags = {
    Environment = "Development"
  }
}
