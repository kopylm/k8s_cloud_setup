################################################################################
# Application Gateway
################################################################################
resource "azurerm_application_gateway" "appgw" {
  name                = "${var.project_name}-appgw"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "${var.project_name}-appgw-ip-config"
    subnet_id = azurerm_subnet.appgw_subnet.id
  }

  frontend_port {
    name = "${var.project_name}-appgw-frontend-port"
    port = var.appgw_frontend_port
  }

  frontend_ip_configuration {
    name                 = "${var.project_name}-appgw-frontend-ip"
    public_ip_address_id = azurerm_public_ip.appgw_public_ip.id
  }

  backend_address_pool {
    name = "${var.project_name}-appgw-backend-pool"
  }

  backend_http_settings {
    name                  = "${var.project_name}-appgw-backend-settings"
    cookie_based_affinity = "Disabled"
    port                  = var.appgw_backend_port
    protocol              = "Http"
    request_timeout       = var.appgw_backend_timeout
  }

  http_listener {
    protocol                       = "Http"
    name                           = "${var.project_name}-appgw-http-listener"
    frontend_ip_configuration_name = "${var.project_name}-appgw-frontend-ip"
    frontend_port_name             = "${var.project_name}-appgw-frontend-port"
  }

  request_routing_rule {
    priority                   = 100
    rule_type                  = "Basic"
    name                       = "${var.project_name}-appgw-routing-rule"
    http_listener_name         = "${var.project_name}-appgw-http-listener"
    backend_address_pool_name  = "${var.project_name}-appgw-backend-pool"
    backend_http_settings_name = "${var.project_name}-appgw-backend-settings"
  }

  tags = var.tags_base
}
