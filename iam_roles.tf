resource "aws_iam_role" "_" {
  name               = var.name
  assume_role_policy = var.assume_role_policy
}
