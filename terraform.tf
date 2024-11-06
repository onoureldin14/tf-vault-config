terraform {
    backend "s3" {
        bucket         = "terraform-state-7bqml8"
        key            = "tf-vault-config/terraform.tfstate"
        region         = "eu-west-2"
        dynamodb_table = "terraform-app-state-lock"
    }    
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "~> 4.4.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.45.0"
    }    
  }
}