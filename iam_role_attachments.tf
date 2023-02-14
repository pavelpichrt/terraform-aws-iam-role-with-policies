resource "aws_iam_role_policy_attachment" "_" {
  count = length(local.all_policy_arns)

  role       = aws_iam_role._.name
  policy_arn = local.all_policy_arns[count.index]
}
