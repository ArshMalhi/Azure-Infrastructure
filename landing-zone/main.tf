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

module "policy_allowed_locations" {
  source = "../modules/policy-assignment"

  name                   = "allowed-locations-${local.name_suffix}"
  subscription_id        = data.azurerm_subscription.current.id
  policy_display_name    = "Allowed locations"
  parameters             = { listOfAllowedLocations = ["australiaeast", "australiasoutheast", "australiacentral"] }
  enforce                = true
  non_compliance_message = "You may only establish Citadel in Australia at the Moment."
}

module "policy_allowed_locations_rg" {
  source = "../modules/policy-assignment"

  name                   = "allowed-locations-rg-${local.name_suffix}"
  subscription_id        = data.azurerm_subscription.current.id
  policy_display_name    = "Allowed locations for resource groups"
  parameters             = { listOfAllowedLocations = ["australiaeast", "australiasoutheast", "australiacentral"] }
  enforce                = true
  non_compliance_message = "You may only establish Citadel resources in Australia at the Moment."
}

module "policy_required_tags" {
  source   = "../modules/policy-assignment"
  for_each = toset(["owner", "environment", "workload"])

  name                   = "require-tag-${each.key}"
  subscription_id        = data.azurerm_subscription.current.id
  policy_display_name    = "Require a tag on resources"
  parameters             = { tagName = each.key }
  enforce                = false # report only, for now
  non_compliance_message = "Every resource needs a '${each.key}' tag."
}