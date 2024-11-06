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

