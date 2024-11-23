############################################################################################################
# Github Actions to Vault App Role Authentication
############################################################################################################

resource "vault_auth_backend" "approle" {
  count = var.tf_cloud_backend == false ? 1 : 0
  type  = "approle"
}

resource "vault_policy" "github_actions_policy" {
  count  = var.tf_cloud_backend == false ? 1 : 0
  name   = "github-actions-policy"
  policy = <<EOT
path "aws/*" {
  capabilities = ["create", "read", "update", "patch", "delete", "list"]
}
EOT
}


resource "vault_policy" "github_aws_backend_read_policy" {
  count  = var.tf_cloud_backend == false ? 1 : 0
  name   = "github-aws-read-policy"
  policy = <<EOT
path "auth/token/lookup-self" {
  capabilities = ["read"]
}
path "${var.aws_secrets_backend_path}/creds/deploy" {
  capabilities = ["read"]
}
EOT
}

resource "vault_approle_auth_backend_role" "github_actions_role" {
  count              = var.tf_cloud_backend == false ? 1 : 0
  backend            = vault_auth_backend.approle[0].path
  role_name          = var.vault_app_role_name
  token_type         = "batch"
  token_policies     = [vault_policy.github_actions_policy[0].name]
  secret_id_ttl      = 600
  token_ttl          = 1200
  token_max_ttl      = 1800
  secret_id_num_uses = 40
}



############################################################################################################
# Terraform Cloud to Vault OIDC Authentication
############################################################################################################

resource "vault_jwt_auth_backend" "tfc_jwt" {
  count              = var.tf_cloud_backend == true ? 1 : 0
  path               = var.jwt_backend_path
  type               = "jwt"
  oidc_discovery_url = "https://${var.tfc_hostname}"
  bound_issuer       = "https://${var.tfc_hostname}"
}

resource "vault_jwt_auth_backend_role" "tfc_role" {
  count          = var.tf_cloud_backend == true ? 1 : 0
  backend        = vault_jwt_auth_backend.tfc_jwt[0].path
  role_name      = var.jwt_auth_role_name
  token_policies = [vault_policy.tfc_policy[0].name]

  bound_audiences = [var.tfc_vault_audience]

  bound_claims_type = "glob"
  bound_claims = {
    # sub = "organization:${var.tfc_organization_name}:project:${var.tfc_project_name}:workspace:*"
    sub = "organization:${var.tfc_organization_name}:project:*"
  }

  user_claim = "terraform_full_workspace"
  role_type  = "jwt"
  token_ttl  = 1200
}

resource "vault_policy" "tfc_policy" {
  count = var.tf_cloud_backend == true ? 1 : 0
  name  = "tfc-policy"

  policy = <<EOT
# Allow tokens to query themselves
path "auth/token/lookup-self" {
  capabilities = ["read"]
}

# Allow tokens to renew themselves
path "auth/token/renew-self" {
    capabilities = ["update"]
}

# Allow tokens to revoke themselves
path "auth/token/revoke-self" {
    capabilities = ["update"]
}

path "aws/*" {
  capabilities = ["create", "read", "update", "patch", "delete", "list"]
}
EOT
}
