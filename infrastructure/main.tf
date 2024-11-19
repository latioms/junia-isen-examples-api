terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "${var.project_name}-${var.environment}-rg"
  location = var.location
  tags     = var.tags
}

# Network Module
module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.main.name
  location           = var.location
  project_name       = var.project_name
  environment        = var.environment
  address_space      = ["10.0.0.0/16"]
  tags              = var.tags
}

# Database Module
module "database" {
  source              = "./modules/database"
  resource_group_name = azurerm_resource_group.main.name
  location           = var.location
  project_name       = var.project_name
  environment        = var.environment
  administrator_login = var.db_administrator_login
  administrator_password = var.db_administrator_password
  subnet_id          = module.network.database_subnet_id
  tags              = var.tags
}

# Storage Module
module "storage" {
  source              = "./modules/storage"
  resource_group_name = azurerm_resource_group.main.name
  location           = var.location
  project_name       = var.project_name
  environment        = var.environment
  tags              = var.tags
}

# App Service Module
module "app_service" {
  source              = "./modules/app-service"
  resource_group_name = azurerm_resource_group.main.name
  location           = var.location
  project_name       = var.project_name
  environment        = var.environment
  subnet_id          = module.network.app_service_subnet_id
  database_url       = module.database.database_url
  storage_connection_string = module.storage.connection_string
  tags              = var.tags
}
