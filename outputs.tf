variable "iam_user_name" {
  description = "The name of the IAM User created."
  value       = "${aws_iam_user.rubrik.name}"
}
