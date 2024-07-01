################################################################################
# AKS configuration
################################################################################
resource "azurerm_kubernetes_cluster" "aks" {
  name                      = "${var.project_name}-cluster"
  location                  = azurerm_resource_group.aks.location
  resource_group_name       = azurerm_resource_group.aks.name
  dns_prefix                = var.aks_dns_prefix
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  default_node_pool {
    name           = "default"
    node_count     = 2
    vm_size        = "Standard_DS2_v2"
    vnet_subnet_id = azurerm_subnet.aks_subnet.id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.agic_identity.id]
  }

  network_profile {
    network_plugin = "azure"
  }

  depends_on = [
    azurerm_role_assignment.agic_identity_contributor,
    azurerm_role_assignment.agic_identity_reader,
    azurerm_role_assignment.agic_identity_network_contributor
  ]
  tags = var.tags_base
}
