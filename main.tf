resource "github_repository" "this" {
  name                   = var.github_repository_name
  visibility             = "public"
  delete_branch_on_merge = true
  homepage_url           = "https://registry.terraform.io/modules/Azure/${local.module_registry_name}/azurerm"

  template {
    owner      = "Azure"
    repository = "terraform-azurerm-avm-template"
  }
}

resource "github_repository_environment" "test" {
  repository  = github_repository.this.id
  environment = "test"
  reviewers {
    users = [data.github_user.owner_username.id]
  }
}

resource "github_team" "owners" {
  name = "${local.module_registry_name}-owners-tf"
}

resource "github_team" "contributors" {
  name = "${local.module_registry_name}-contributors-tf"
}

data "github_team" "avm_core_team_technical_terraform" {
  slug = "avm-core-team-technical-terraform"
}

data "github_team" "terraform_azure" {
  slug = "terraform-azure"
}

data "github_user" "owner_username" {
  username = var.github_owner_username
}

resource "github_team_repository" "this" {
  for_each   = local.team_repository_map
  repository = github_repository.this.id
  team_id    = each.value.team_id
  permission = each.value.permission
}
