terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.11"
    }
  }

  # Values come from backend.hcl:
  #   tf init -backend-config=backend.hcl
  backend "azurerm" {}
}

provider "azurerm" {
  subscription_id                 = var.subscription_id
  resource_provider_registrations = "core"
  storage_use_azuread             = true
  features {}
}