############################################################################################################
# AWS IAM User and Access Key for Vault Trust Relationships
############################################################################################################

resource "aws_iam_user" "trust_relationships" {
  name = local.aws_iam_user
}

resource "aws_iam_access_key" "trust_relationships" {
  user = aws_iam_user.trust_relationships.name
}

resource "aws_iam_user_policy" "trust_relationships" {
  user = aws_iam_user.trust_relationships.name
  policy = jsonencode({
    Statement = [
      {
        Action = [
          "iam:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
    Version = "2012-10-17"
  })
}
