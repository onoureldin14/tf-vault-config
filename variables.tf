variable "tf_cloud_backend" {
  description = "Enable Terraform Cloud as the backend for the trust relationships project."
  type        = bool
  default     = true
}

variable "enable_vault_ca" {
  description = "Enable Vault CA backend."
  type        = bool
  default     = false

}

variable "repositories" {
  type    = list(string)
  default = ["tf-vmt-app"]
}



variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}

variable "tfc_token" {
  description = "Token for authenticating with Terraform Cloud"
  type        = string
  sensitive   = true
}

variable "vault_public_address" {
  description = "Public address of the Vault server"
  type        = string
  sensitive   = true
}

variable "vault_app_role_name" {
  type        = string
  default     = "github-actions-role"
  description = "The name of the approle role to create."
}

variable "vault_token" {
  description = "Token for authenticating with Vault"
  type        = string
  sensitive   = true
  default     = "value"
}


variable "aws_region" {
  type        = string
  default     = "eu-west-2"
  description = "AWS London region, used for all resources."
}


variable "vault_namespace" {
  type        = string
  default     = "admin"
  description = "The namespace of the Vault instance."
}

variable "aws_secrets_backend_role_name" {
  type        = string
  default     = "deploy"
  description = "The name of the role to create in the AWS secrets engine."
}

variable "aws_secret_backend_credential_type" {
  type        = string
  default     = "iam_user"
  description = "The type of credential to use for the AWS secrets engine."
}

variable "aws_secrets_backend_path" {
  type        = string
  default     = "aws"
  description = "The path at which to mount the aws secrets engine backend in Vault."
}

variable "jwt_auth_role_name" {
  type        = string
  default     = "tfc-role"
  description = "The name of the role to create in the JWT auth backend."

}

variable "jwt_backend_path" {
  type        = string
  default     = "tfc_jwt_vault"
  description = "The path at which to mount the jwt auth backend in Vault."
}

variable "tfc_project_name" {
  type        = string
  default     = "AWS Dynmaic Trust Relationship"
  description = "The name of the trust relationships project."
}

variable "tfc_vault_audience" {
  type        = string
  default     = "vault.workload.identity"
  description = "The audience value to use in run identity tokens"
}

variable "tfc_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE instance."
}

variable "tfc_organization_name" {
  type        = string
  description = "The name of your Terraform Cloud organization."
  default     = "Onoureldin"
}

variable "tfc_variable_set_name" {
  type        = string
  default     = "HCP Vault Variables for TFC Trust Relationship"
  description = "TFC Variable Set Name"
}
