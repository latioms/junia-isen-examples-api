resource "azurerm_postgresql_flexible_server" "main" {
  name                = "${var.project_name}-${var.environment}-db"
  resource_group_name = var.resource_group_name
  location           = var.location
  version            = "13"
  delegated_subnet_id = var.subnet_id
  private_dns_zone_id = azurerm_private_dns_zone.database.id
  
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  storage_mb = 32768
  sku_name   = "B_Standard_B1ms"
  tags       = var.tags
}

resource "azurerm_private_dns_zone" "database" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}