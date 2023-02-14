terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 4.20"
    }
  }
}

# =============================================

variable "name" {}

variable "assume_role_policy" {}

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

output "policy_arns" {
  value = local.all_policy_arns
}
