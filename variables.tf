variable "vault_public_address" {
  description = "Public address of the Vault server"
  type        = string
  sensitive   = true
  default = "value"
}


variable "vault_token" {
  description = "Token for authenticating with Vault"
  type        = string
  sensitive   = true
  default = "value"
}