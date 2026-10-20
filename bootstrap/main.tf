data "azurerm_client_config" "current" {}

locals {
  tags = {
    workload   = var.workload
    purpose    = "terraform-state"
    owner      = var.owner
    managed_by = "terraform"
  }
}

resource "random_string" "suffix" {
  length  = 5
  upper   = false
  special = false
}

resource "azurerm_resource_group" "tfstate" {
  name     = "rg-${var.workload}-tfstate"
  location = var.location
  tags     = local.tags
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "st${var.workload}tf${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  # Hardening
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = false # Entra ID auth only

  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = 7
    }

    container_delete_retention_policy {
      days = 7
    }
  }

  tags = local.tags
}

# Owner/Contributor do not include blob DATA permissions, so grant them
# explicitly to whoever runs Terraform.
resource "azurerm_role_assignment" "state_blob_contributor" {
  scope                = azurerm_storage_account.tfstate.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "time_sleep" "wait_for_rbac" {
  depends_on      = [azurerm_role_assignment.state_blob_contributor]
  create_duration = "60s"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"

  depends_on = [time_sleep.wait_for_rbac]
}

# Stop the state storage being deleted by accident (AZ-104: resource locks).
resource "azurerm_management_lock" "tfstate" {
  name       = "lock-${var.workload}-tfstate"
  scope      = azurerm_resource_group.tfstate.id
  lock_level = "CanNotDelete"
  notes      = "Holds Terraform state for Citadel. Remove deliberately, never by accident."

  depends_on = [azurerm_storage_container.tfstate]
}