output "app_service_url" {
  description = "URL of the App Service"
  value       = module.app_service.app_service_url
}

output "database_url" {
  description = "Database connection string"
  value       = module.database.database_url
  sensitive   = true
}

output "storage_connection_string" {
  description = "Storage account connection string"
  value       = module.storage.connection_string
  sensitive   = true
}