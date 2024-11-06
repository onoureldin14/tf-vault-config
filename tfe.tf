############################################################################################################
# Define following environment variables in your Terraform configuration, Workspace Settings
############################################################################################################

resource "tfe_variable_set" "trust_relationships" {
  name         = var.tfc_variable_set_name
  description  = "Variables required to create trust relationships."
  organization = var.tfc_organization_name
}


resource "tfe_variable" "tfc_vault_addr" {
  key             = "TFC_VAULT_ADDR"
  value           = var.vault_public_address
  category        = "env"
  sensitive       = true
  description     = "The address of the Vault instance runs will access."
  variable_set_id = tfe_variable_set.trust_relationships.id
}

resource "tfe_variable" "tfc_vault_namespace" {
  key             = "VAULT_NAMESPACE"
  value           = "admin"
  category        = "env"
  description     = "Vault namespace."
  variable_set_id = tfe_variable_set.trust_relationships.id
}

resource "tfe_variable" "tfc_vault_provider_auth" {
  key             = "TFC_VAULT_PROVIDER_AUTH"
  value           = "true"
  category        = "env"
  description     = "boolean flag that must be set to true to enable the Vault provider as needed in Terraform"
  variable_set_id = tfe_variable_set.trust_relationships.id
}