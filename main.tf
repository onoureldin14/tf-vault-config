############################################################################################################
# Github Actions to Vault App Role Authentication
############################################################################################################

resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_policy" "github_read_policy" {
  name   = "github-read-policy"
  policy = <<EOT
path "secret/data/github/*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_approle_auth_backend_role" "github_role" {
  backend             = vault_auth_backend.approle.path
  role_name           = "my-role"
  token_type          = "batch"
  secret_id_ttl       = 600
  token_ttl           = 1200
  token_max_ttl       = 1800
  secret_id_num_uses  = 40
  token_num_uses      = 0
}

resource "vault_approle_auth_backend_role_secret_id" "github_role_secret_id" {
  backend  = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.github_role.role_name
}

############################################################################################################
# Terraform Cloud to Vault OIDC Authentication
############################################################################################################

resource "vault_jwt_auth_backend" "tfc_jwt" {
  path               = var.jwt_backend_path
  type               = "jwt"
  oidc_discovery_url = "https://${var.tfc_hostname}"
  bound_issuer       = "https://${var.tfc_hostname}"
}

resource "vault_jwt_auth_backend_role" "tfc_vault_config" {
backend           = vault_jwt_auth_backend.tfc_jwt.path
role_name         = "tfc_jwt_all_projects"
token_policies    = [ "tfc_all_projects" ]
user_claim        = "terraform_full_workspace"
role_type         = "jwt"
bound_audiences   = ["vault.workload.identity"]
bound_claims_type = "glob"
token_ttl         = 20 * 60
bound_claims = {
sub = "organization:${var.tfc_organization_name}:project:*:workspace:*:run_phase:*"
}
}
        