data "azurerm_subscription" "current" {}

module "resource_group" {
  source   = "../modules/resource-group"
  for_each = local.resource_groups

  name     = "rg-${local.name_suffix}-${each.key}"
  location = var.location
  tags     = merge(local.tags, { purpose = each.value })
}

module "budget" {
  source = "../modules/budget"

  name            = "budget-${local.name_suffix}"
  subscription_id = data.azurerm_subscription.current.id
  amount          = var.monthly_budget
  start_date      = "2026-10-01T00:00:00Z"
  contact_emails  = [var.alert_email]
}