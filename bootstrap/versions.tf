terraform {
  required_version = ">= 1.9.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.81"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.12"
    }   
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  resource_provider_registrations = "core"
  storage_use_azuread = true
  features{}
}