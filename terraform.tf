terraform {
  # backend "s3" {
  #     bucket         = "terraform-state-7bqml8"
  #     key            = "tf-vault-config/terraform.tfstate"
  #     region         = "eu-west-2"
  #     dynamodb_table = "terraform-app-state-lock"
  # }
  backend "remote" {
    organization = "Onoureldin"
    workspaces {
      name = "tf-vault-config"
    }
  }
  required_version = ">= 0.14.9"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.45.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1.0"
    }
  }
}
