locals {
  aws_iam_user = "hc-vault-secrets-engine-${random_string.name_suffix.result}"
}
