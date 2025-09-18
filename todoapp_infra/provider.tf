terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.33.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "af4c13b7-6f21-4684-a981-6f96cb90a98b"
}