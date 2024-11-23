provider "vault" {
  address = var.vault_public_address
  token   = var.vault_token
}


provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

provider "tfe" {
  hostname = var.tfc_hostname
  token    = var.tfc_token
}
