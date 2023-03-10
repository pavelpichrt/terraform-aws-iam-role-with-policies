terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 4.20"
    }
  }
}

# =============================================

variable "name" {
  description = "Name of a role to be created."
}

variable "assume_role_policy" {
  description = "Can be provided for example via `data.aws_iam_policy_document.xxx.json` or HEREDOC syntax. See example."
}

variable "attach_policy_documents" {
  type        = list(string)
  default     = []
  description = "A list of policy documents in JSON format, usually data.aws_iam_policy_document.xxx.json"
}

variable "attach_policy_arns" {
  type    = list(string)
  default = []
}

locals {
  all_policy_arns = concat(var.attach_policy_arns, [
    for idx, policy in aws_iam_policy.from_document : policy.arn
  ])
}

# =============================================

output "_" {
  value = aws_iam_role._
}

# This is useful when you need to refer to the created policies
output "policies" {
  value = aws_iam_policy.from_document
}
