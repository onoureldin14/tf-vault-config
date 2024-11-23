############################################################################################################
# Creating Project. Defining & Attaching environment variables in Terraform Project, required by Vault
############################################################################################################

resource "tfe_project" "trust_relationships" {
  count        = var.tf_cloud_backend == true ? 1 : 0
  name         = var.tfc_project_name
  organization = var.tfc_organization_name
}

# resource "tfe_workspace" "tf_vmt_app" {
#   count = var.tf_cloud_backend == true ? 1 : 0
#   name = "tf-vmt-app"
#   organization = var.tfc_organization_name
#   project_id = tfe_project.trust_relationships.id
# }

# resource "tfe_workspace_variable_set" "workload" {
#   count = var.tf_cloud_backend == true ? 1 : 0
#   variable_set_id = tfe_variable_set.trust_relationships.id
#   workspace_id    = tfe_workspace.tf_vmt_app.id
# }

resource "tfe_workspace" "workspaces" {
  for_each     = var.tf_cloud_backend == true ? toset(var.repositories) : toset([])
  name         = each.key
  organization = var.tfc_organization_name
  project_id   = tfe_project.trust_relationships[0].id
  force_delete = true
}

resource "tfe_variable_set" "trust_relationships" {
  count        = var.tf_cloud_backend == true ? 1 : 0
  name         = var.tfc_variable_set_name
  description  = "Variables required to create trust relationships."
  organization = var.tfc_organization_name
}

resource "tfe_project_variable_set" "trust_relationships" {
  count           = var.tf_cloud_backend == true ? 1 : 0
  variable_set_id = tfe_variable_set.trust_relationships[0].id
  project_id      = tfe_project.trust_relationships[0].id
}

resource "tfe_workspace_variable_set" "workload" {
  for_each = var.tf_cloud_backend == true ? tfe_workspace.workspaces : {}

  variable_set_id = tfe_variable_set.trust_relationships[0].id
  workspace_id    = each.value.id
}




resource "tfe_variable" "tfc_vault_addr" {
  count           = var.tf_cloud_backend == true ? 1 : 0
  key             = "TFC_VAULT_ADDR"
  value           = var.vault_public_address
  category        = "env"
  sensitive       = true
  description     = "The address of the Vault instance runs will access."
  variable_set_id = tfe_variable_set.trust_relationships[0].id
}

resource "tfe_variable" "tfc_vault_namespace" {
  count           = var.tf_cloud_backend == true ? 1 : 0
  key             = "TFC_VAULT_NAMESPACE"
  value           = var.vault_namespace
  category        = "env"
  description     = "Vault namespace."
  variable_set_id = tfe_variable_set.trust_relationships[0].id
}

resource "tfe_variable" "vault_jwt_path" {
  count           = var.tf_cloud_backend == true ? 1 : 0
  key             = "TFC_VAULT_AUTH_PATH"
  value           = var.jwt_backend_path
  category        = "env"
  description     = "Vault namespace."
  variable_set_id = tfe_variable_set.trust_relationships[0].id

}

resource "tfe_variable" "tfc_vault_provider_auth" {
  count           = var.tf_cloud_backend == true ? 1 : 0
  key             = "TFC_VAULT_PROVIDER_AUTH"
  value           = "true"
  category        = "env"
  description     = "boolean flag that must be set to true to enable the Vault provider as needed in Terraform"
  variable_set_id = tfe_variable_set.trust_relationships[0].id
}

resource "tfe_variable" "tfc_vault_run_role" {
  count           = var.tf_cloud_backend == true ? 1 : 0
  key             = "TFC_VAULT_RUN_ROLE"
  value           = var.jwt_auth_role_name
  category        = "env"
  description     = "The name of the Vault JWT Backend to authenticate against"
  variable_set_id = tfe_variable_set.trust_relationships[0].id
}

resource "tfe_variable" "tfc_vault_aws_provider_auth" {
  count           = var.tf_cloud_backend == true ? 1 : 0
  key             = "TFC_VAULT_BACKED_AWS_AUTH"
  value           = "true"
  category        = "env"
  description     = "boolean flag must be present and set to true, or HCP Terraform will not attempt to authenticate with AWS"
  variable_set_id = tfe_variable_set.trust_relationships[0].id
}

resource "tfe_variable" "tfc_vault_aws_auth_backend" {
  count           = var.tf_cloud_backend == true ? 1 : 0
  key             = "TFC_VAULT_BACKED_AWS_AUTH_TYPE"
  value           = var.aws_secret_backend_credential_type
  category        = "env"
  description     = "Specifies the type of authentication to perform with AWS. Must be one of the following: iam_user, assumed_role, or federation_token"
  variable_set_id = tfe_variable_set.trust_relationships[0].id
}

resource "tfe_variable" "tfc_vault_backend_aws_run_role" {
  count           = var.tf_cloud_backend == true ? 1 : 0
  key             = "TFC_VAULT_BACKED_AWS_RUN_VAULT_ROLE"
  value           = var.aws_secrets_backend_role_name
  category        = "env"
  description     = "The role to use in Vault."
  variable_set_id = tfe_variable_set.trust_relationships[0].id
}
