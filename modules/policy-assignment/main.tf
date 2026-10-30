# Look up the built-in policy by its portal name, so there are no magic GUIDs
data "azurerm_policy_definition" "this" {
  display_name = var.policy_display_name
}

resource "azurerm_subscription_policy_assignment" "this" {
  name                 = var.name
  display_name         = var.name
  subscription_id      = var.subscription_id
  policy_definition_id = data.azurerm_policy_definition.this.id
  enforce              = var.enforce

  # Azure wants {"tagName": {"value": "owner"}}, so wrap each value
  parameters = jsonencode({
    for key, value in var.parameters : key => { value = value }
  })

  non_compliance_message {
    content = var.non_compliance_message
  }
}