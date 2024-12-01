output "role_id" {
  value     = var.tf_cloud_backend == false ? data.vault_approle_auth_backend_role_id.github_actions_role[0].role_id : null
  sensitive = true
}

# vault read auth/approle/role/github-actions-role/role-id
# vault write -f auth/approle/role/github-actions-role/secret-id


# output "vault_pki_secret_backend_root_cert_root_2024" {
#   value = vault_pki_secret_backend_root_cert.root_2024.certificate
# }

# output "vault_pki_secret_backend_cert_example-dot-com_issuring_ca" {
#   value = vault_pki_secret_backend_cert.example-dot-com.issuing_ca
# }

# output "vault_pki_secret_backend_cert_example-dot-com_cert" {
#   value = vault_pki_secret_backend_cert.example-dot-com.certificate
# }

# output "vault_pki_secret_backend_cert_example-dot-com_serial_number" {
#   value = vault_pki_secret_backend_cert.example-dot-com.serial_number
# #   sensitive = true
# }

# output "vault_pki_secret_backend_cert_example-dot-com_private_key_type" {
#   value = vault_pki_secret_backend_cert.example-dot-com.private_key_type
# }

# output "root_2024_ca" {
#     value = vault_pki_secret_backend_root_cert.root_2024.certificate
#     description = "Root CA Certificate"
# }

# output "intermediate_ca_cert" {
#     value = vault_pki_secret_backend_root_sign_intermediate.intermediate.certificate
#     description = "Intermediate CA Certificate"
# }

# output "end_entity_certificates" {
#     value = vault_pki_secret_backend_cert.example-dot-com.certificate
#     description = "End Entity Certificates"

# }
