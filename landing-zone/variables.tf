variable "subscription_id" {
  description = "Azure subscription ID to deploy into."
  type        = string
}

variable "workload" {
  description = "Short workload name used in resource names."
  type        = string
  default     = "citadel"
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment must be one of: dev, test, prod."
  }
}

variable "location" {
  description = "Primary Azure region."
  type        = string
  default     = "australiaeast"
}

variable "owner" {
  description = "Owner tag value."
  type        = string
  default     = "Arsh Malhi"
}