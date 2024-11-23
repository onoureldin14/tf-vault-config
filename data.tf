data "vault_approle_auth_backend_role_id" "github_actions_role" {
  count     = var.tf_cloud_backend == false ? 1 : 0
  backend   = "approle"
  role_name = var.vault_app_role_name
}
