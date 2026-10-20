variable "subscription_id" {
  description = "The subscription ID for the Azure account."
  type        = string
}
variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "australiaeast"
}

variable "workload" {
  description = "The workload name for the deployment."
  type        = string
  default     = "citadel"
}

variable "owner" {
  description = "The owner of the deployment."
  type        = string
  default     = "Arsh Malhi"
}