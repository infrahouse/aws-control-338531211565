variable "environment" {
  type        = string
  description = "Environment name (development, staging, production, etc.)"

  validation {
    condition     = can(regex("^[a-z0-9_]+$", var.environment))
    error_message = "environment must contain only lowercase letters, numbers, and underscores (no hyphens)"
  }
}