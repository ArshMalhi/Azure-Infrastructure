variable "name" {
  description = "Short name for the assignment, e.g. allowed-locations. or a unique name for a custom policy."
  type        = string
}

variable "subscription_id" {
  description = "Full subscription resource ID"
  type        = string
}

variable "policy_display_name" {
  description = "The built-in policy's name exactly as the portal shows it."
  type        = string
}

variable "parameters" {
  description = "Settings the policy needs, e.g. { tagName = \"owner\" }."
  type        = any
  default     = {}
}

variable "enforce" {
  description = "true = block anything that breaks the rule. false = report only."
  type        = bool
  default     = true
}

variable "non_compliance_message" {
  description = "The message people see when the policy stops them. Like Grr, you can't do that!"
  type        = string
}