terraform {
  required_providers {
    azurerm = {
      source           = "hashicorp/azurerm"
      version          = "~> 4.81"
      required_version = ">= 1.5.0"
    }
  }
}
