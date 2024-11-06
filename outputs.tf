output "role_id" {
  value     = data.vault_approle_auth_backend_role_id.my_role_id.id
  sensitive = true
}

output "secret_id" {
  value     = vault_approle_auth_backend_role_secret_id.github_role_secret_id.secret_id
  sensitive = true
}

output "secret_id_accessor" {
  value     = vault_approle_auth_backend_role_secret_id.github_role_secret_id.accessor
  sensitive = true
}