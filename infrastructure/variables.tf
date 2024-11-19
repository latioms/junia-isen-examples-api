variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "junia-isen-api"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "West Europe"
}

variable "db_administrator_login" {
  description = "Database administrator login"
  type        = string
}

variable "db_administrator_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {
    Project     = "junia-isen-api"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}