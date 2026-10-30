terraform {
  required_providers {
    azurerm = {
      source           = "hashicorp/azurerm"
      version          = "~> 5.11"
      required_version = ">= 1.5.0"
    }
  }
}
