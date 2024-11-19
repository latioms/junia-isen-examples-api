resource "azurerm_service_plan" "main" {
  name                = "${var.project_name}-${var.environment}-plan"
  resource_group_name = var.resource_group_name
  location           = var.location
  os_type            = "Linux"
  sku_name           = "B1"
  tags               = var.tags
}

resource "azurerm_linux_web_app" "main" {
  name                = "${var.project_name}-${var.environment}-app"
  resource_group_name = var.resource_group_name
  location           = var.location
  service_plan_id    = azurerm_service_plan.main.id
  
  site_config {
    application_stack {
      docker_image     = "nginx"
      docker_image_tag = "latest"
    }
  }

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL" = "https://index.docker.io"
    "DATABASE_URL"               = var.database_url
    "STORAGE_CONNECTION_STRING"  = var.storage_connection_string
  }

  virtual_network_subnet_id = var.subnet_id
  tags                     = var.tags
}
