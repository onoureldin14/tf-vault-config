############################################################################################################
# AWS Cloud to Vault Secret Backend
############################################################################################################

resource "vault_aws_secret_backend" "aws_secret_backend" {
  path       = var.aws_secrets_backend_path
  region     = var.aws_region
  access_key = aws_iam_access_key.trust_relationships.id
  secret_key = aws_iam_access_key.trust_relationships.secret
}

resource "vault_aws_secret_backend_role" "role" {
  backend         = vault_aws_secret_backend.aws_secret_backend.path
  name            = var.aws_secrets_backend_role_name
  credential_type = var.aws_secret_backend_credential_type
  policy_arns     = values(aws_iam_policy.policies)[*].arn
}
