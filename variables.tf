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

variable "jwt_backend_path" {
  type        = string
  default     = "tfc_jwt_vault"
  description = "The path at which to mount the jwt auth backend in Vault."
}

variable "tfc_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE instance."
}

variable "tfc_organization_name" {
  type          = string
  description   = "The name of your Terraform Cloud organization."
}

variable "tfc_variable_set_name" {
  type        = string
  default     = "HCP Vault Variables for TFC Trust Relationship"
  description = "TFC Variable Set Name"
}
