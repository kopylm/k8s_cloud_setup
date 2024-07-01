resource "azurerm_user_assigned_identity" "agic_identity" {
  name                = "${var.project_name}-agic-identity"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
}

resource "azurerm_role_assignment" "agic_identity_contributor" {
  principal_id         = azurerm_user_assigned_identity.agic_identity.principal_id
  role_definition_name = "Contributor"
  scope                = azurerm_resource_group.aks.id
}

resource "azurerm_role_assignment" "agic_identity_reader" {
  principal_id         = azurerm_user_assigned_identity.agic_identity.principal_id
  role_definition_name = "Reader"
  scope                = azurerm_resource_group.aks.id
}

resource "azurerm_role_assignment" "agic_identity_network_contributor" {
  principal_id         = azurerm_user_assigned_identity.agic_identity.principal_id
  role_definition_name = "Network Contributor"
  scope                = azurerm_virtual_network.vnet.id
}

resource "azurerm_role_assignment" "agic_identity_appgw_contributor" {
  principal_id         = azurerm_user_assigned_identity.agic_identity.principal_id
  role_definition_name = "Contributor"
  scope                = azurerm_application_gateway.appgw.id
}
