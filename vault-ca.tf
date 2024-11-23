############################################################################################################
# Vault CA Certificate
############################################################################################################

resource "vault_policy" "engine-policy" {
  count = var.enable_vault_ca == true ? 1 : 0
  name  = "engine-policy"

  policy = <<EOT
# Enable secrets engine
path "sys/mounts/*" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}

# List enabled secrets engine
path "sys/mounts" {
  capabilities = [ "read", "list" ]
}

# Work with pki secrets engine
path "pki*" {
  capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
}
EOT
}

resource "vault_mount" "pki" {
  count       = var.enable_vault_ca == true ? 1 : 0
  path        = "pki"
  type        = "pki"
  description = "This is an example PKI mount"

  default_lease_ttl_seconds = 86400
  max_lease_ttl_seconds     = 315360000
}


resource "vault_pki_secret_backend_root_cert" "root_2024" {
  count       = var.enable_vault_ca == true ? 1 : 0
  backend     = vault_mount.pki[0].path
  type        = "internal"
  common_name = "example.com"
  ttl         = 315360000
  issuer_name = "root-2024"
}

resource "vault_pki_secret_backend_issuer" "root_2024" {
  count                          = var.enable_vault_ca == true ? 1 : 0
  backend                        = vault_mount.pki[0].path
  issuer_ref                     = vault_pki_secret_backend_root_cert.root_2024[0].issuer_id
  issuer_name                    = vault_pki_secret_backend_root_cert.root_2024[0].issuer_name
  revocation_signature_algorithm = "SHA256WithRSA"
}


resource "vault_pki_secret_backend_role" "role" {
  count            = var.enable_vault_ca == true ? 1 : 0
  backend          = vault_mount.pki[0].path
  name             = "2024-servers-role"
  allow_ip_sans    = true
  key_type         = "rsa"
  key_bits         = 4096
  allow_subdomains = true
  allow_any_name   = true
}

resource "vault_pki_secret_backend_config_urls" "config-urls" {
  count                   = var.enable_vault_ca == true ? 1 : 0
  backend                 = vault_mount.pki[0].path
  issuing_certificates    = ["http://localhost:8200/v1/pki/ca"]
  crl_distribution_points = ["http://localhost:8200/v1/pki/crl"]
}


resource "vault_mount" "pki_int" {
  count       = var.enable_vault_ca == true ? 1 : 0
  path        = "pki_int"
  type        = "pki"
  description = "This is an example intermediate PKI mount"

  default_lease_ttl_seconds = 86400
  max_lease_ttl_seconds     = 157680000
}


resource "vault_pki_secret_backend_intermediate_cert_request" "csr-request" {
  count       = var.enable_vault_ca == true ? 1 : 0
  backend     = vault_mount.pki_int[0].path
  type        = "internal"
  common_name = "example.com Intermediate Authority"
}


resource "vault_pki_secret_backend_root_sign_intermediate" "intermediate" {
  count       = var.enable_vault_ca == true ? 1 : 0
  backend     = vault_mount.pki[0].path
  common_name = "new_intermediate"
  csr         = vault_pki_secret_backend_intermediate_cert_request.csr-request[0].csr
  format      = "pem_bundle"
  ttl         = 15480000
  issuer_ref  = vault_pki_secret_backend_root_cert.root_2024[0].issuer_id
}


resource "vault_pki_secret_backend_intermediate_set_signed" "intermediate" {
  count       = var.enable_vault_ca == true ? 1 : 0
  backend     = vault_mount.pki_int[0].path
  certificate = vault_pki_secret_backend_root_sign_intermediate.intermediate[0].certificate
}

resource "vault_pki_secret_backend_issuer" "intermediate" {
  count       = var.enable_vault_ca == true ? 1 : 0
  backend     = vault_mount.pki_int[0].path
  issuer_ref  = vault_pki_secret_backend_intermediate_set_signed.intermediate[0].imported_issuers[0]
  issuer_name = "example-dot-com-intermediate"
}

resource "vault_pki_secret_backend_role" "intermediate_role" {
  count            = var.enable_vault_ca == true ? 1 : 0
  backend          = vault_mount.pki_int[0].path
  issuer_ref       = vault_pki_secret_backend_issuer.intermediate[0].issuer_ref
  name             = "example-dot-com"
  ttl              = 86400
  max_ttl          = 2592000
  allow_ip_sans    = true
  key_type         = "rsa"
  key_bits         = 4096
  allowed_domains  = ["example.com"]
  allow_subdomains = true

}

resource "vault_pki_secret_backend_cert" "example-dot-com" {
  count       = var.enable_vault_ca == true ? 1 : 0
  issuer_ref  = vault_pki_secret_backend_issuer.intermediate[0].issuer_ref
  backend     = vault_pki_secret_backend_role.intermediate_role[0].backend
  name        = vault_pki_secret_backend_role.intermediate_role[0].name
  common_name = "test.example.com"
  ttl         = 3600
  revoke      = true
}
