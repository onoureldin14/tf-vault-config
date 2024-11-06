data "vault_approle_auth_backend_role_id" "my_role_id" {
  backend  = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.github_role.role_name
}
