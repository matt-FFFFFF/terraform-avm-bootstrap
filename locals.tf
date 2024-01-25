locals {
  # remove hte prefix terraform-azurerm- from var.repository_name
  module_registry_name = replace(var.github_repository_name, "^terraform-azurerm-", "")
  team_repository_map = {
    terraform_azure = {
      team_id    = data.github_team.terraform_azure.id
      permission = "admin"
    }
    avm_core_team_technical_terraform = {
      team_id    = data.github_team.avm_core_team_technical_terraform.id
      permission = "admin"
    }
    owners = {
      team_id    = github_team.owners.id
      permission = "admin"
    }
    contributors = {
      team_id    = github_team.contributors.id
      permission = "push"
    }
  }
}
