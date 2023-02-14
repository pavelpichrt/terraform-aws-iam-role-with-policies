resource "aws_iam_policy" "from_document" {
  count = length(var.attach_policy_documents)

  name   = count.index == 0 ? var.name : "${var.name}-${count.index}"
  policy = var.attach_policy_documents[count.index]
}
