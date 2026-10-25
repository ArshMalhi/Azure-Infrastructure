resource "azurerm_consumption_budget_subscription" "this" {
  name            = var.name
  subscription_id = var.subscription_id
  amount          = var.amount
  time_grain      = "Monthly"

  time_period {
    start_date = var.start_date
  }

  # Alert 1: you've actually spent 80% of the budget
  notification {
    enabled        = true
    operator       = "GreaterThan"
    threshold      = 80
    threshold_type = "Actual"
    contact_emails = var.contact_emails
  }

  # Alert 2: Azure predicts you'll go over by month end
  notification {
    enabled        = true
    operator       = "GreaterThan"
    threshold      = 100
    threshold_type = "Forecasted"
    contact_emails = var.contact_emails
  }
}
