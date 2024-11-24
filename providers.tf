provider "vault" {
  address = var.vault_public_address
  token   = var.vault_token
}


provider "aws" {
  region = var.aws_region
}

provider "tfe" {
  hostname = var.tfc_hostname
}
