variable "github_repository_name" {
  type        = string
  description = "The name of the repository. E.g. terraform-azurerm-avm-<name>"
  nullable    = false

  validation {
    error_message = "The repository name must begin with `terraform-azurerm-avm-(res|ptn)`."
    condition     = can(regex("^terraform-azurerm-avm-(res|ptn).*", var.github_repository_name))
  }

  validation {
    error_message = "The repository name must be in lowercase and contain a-z, 0-9, and -."
    condition     = can(regex("^[a-z0-9-]+$", var.github_repository_name))
  }
}

variable "github_owner_username" {
  type        = string
  description = "Your GitHub username."
  nullable    = false

  validation {
    error_message = "Must not be blank."
    condition     = can(regex("^.+$", var.github_owner_username))
  }
}

variable "github_organization" {
  type        = string
  description = "The GitHub organization to create the repository in."
  nullable    = false
  default     = "LogicoreUK"

  validation {
    error_message = "Must not be blank."
    condition     = can(regex("^.+$", var.github_organization))
  }
}
