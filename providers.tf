provider "vault" {
  address = var.vault_public_address
  token   = var.vault_token             
}

provider "tfe" {
  hostname = var.tfc_hostname
}
