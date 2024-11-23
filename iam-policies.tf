resource "aws_iam_policy" "policies" {
  for_each    = toset(var.repositories)
  name        = "${each.key}-policy"
  description = "IAM policy for ${each.key}"
  policy      = file("${path.module}/policies/${each.key}.json")
}
