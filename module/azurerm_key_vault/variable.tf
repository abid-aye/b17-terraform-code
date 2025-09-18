variable "key_vault_name" {
  description = "The name of the Azure Key Vault."
  type        = string
}

variable "key_vault_location" {
  description = "The Azure location where the Key Vault will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the Key Vault will be created."
  type        = string
}

variable "admin_username" {
  description = "The administrator username for the Key Vault."
  type        = string
  sensitive = true
}

variable "admin_password" {
  description = "The administrator password for the Key Vault."
  type        = string
  sensitive   = true
}