output "kubeconfig" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "agic_identity_client_id" {
  value = azurerm_user_assigned_identity.agic_identity.client_id
}

output "agic_identity_id" {
  value = azurerm_user_assigned_identity.agic_identity.id
}

output "agic_identity_principal_id" {
  value = azurerm_user_assigned_identity.agic_identity.principal_id
}
