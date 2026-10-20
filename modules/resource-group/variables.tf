variable "name" {
  description = "Resource group name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "tags" {
  description = "Tags to apply."
  type        = map(string)
  default     = {}
}

variable "lock_level" {
  description = "Optional management lock: CanNotDelete, ReadOnly, or null for no lock."
  type        = string
  default     = null

  validation {
    condition     = var.lock_level == null || contains(["CanNotDelete", "ReadOnly"], coalesce(var.lock_level, "none"))
    error_message = "lock_level must be CanNotDelete, ReadOnly, or null."
  }
}