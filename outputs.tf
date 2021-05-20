output "aws_iam_user_name" {
  description = "The name of the AWS IAM User created."
  value       = "${aws_iam_user.rubrik.name}"
}

output "rubrik_archive_name" {
  description = "The name of the archival location created on the Rubrik cluster."
  value       = "${rubrik_aws_s3_cloudout.archive-target.archive_name}"
}
