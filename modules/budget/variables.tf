variable "name" {
  description = "Budget name."
  type        = string
}

variable "subscription_id" {
  description = "Full subscription resource ID, e.g. /subscriptions/0000..."
  type        = string
}

variable "amount" {
  description = "Monthly budget (AUD)."
  type        = number
}

variable "start_date" {
  description = "First day of a month, e.g. 2026-10-01T00:00:00Z."
  type        = string
}

variable "contact_emails" {
  description = "Who gets the alert emails."
  type        = list(string)
}