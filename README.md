# Terraform module: IAM Role with policies

A utility module that simplifies creating an IAM role with a trust policy with multiple managed or custom attached policies.

## Usage

```terraform
data "aws_iam_policy_document" "example" {
  statement {
    sid    = "AutoScaling"
    effect = "Allow"
    actions = [
      "autoscaling:Describe*"
    ]
    resources = ["*"]
  }
}

module "role_example" {
  source = "pavelpichrt/iam-role-with-policies/aws"

  name = "my-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = {
      Effect = "Allow"
      Action = "sts:AssumeRole"

      Principal = {
        Service = "ecs.amazonaws.com"
      }
    }
  })

  attach_policy_documents = [data.aws_iam_policy_document.example.json]
  attach_policy_arns = [
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/AutoScalingFullAccess",
  ]
}

output "created_role" {
  value = module.role_example._
}


output "created_policies" {
  value = module.role_example.policies
}
```
