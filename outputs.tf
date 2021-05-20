data "template_file" "iam_secret_key" {
  template = aws_iam_access_key.rubrik-user.secret
}

output "aws_iam_user_info" {
  description = "The information about the AWS IAM User created."
  value       = {
    "name"               = aws_iam_user.rubrik.name
    "aws_iam_access_key" = aws_iam_access_key.rubrik-user.id
    "aws_iam_secret_key" = data.template_file.iam_secret_key.rendered
  }
}

output "aws_iam_policy" {
  description = "The name ofthe AWS Policy created for the IAM User."
  value       = aws_iam_policy.cloud-out-permissions.name
}

output "aws_bucket" {
  description = "The AWS S3 bucket that was created."
  value       = aws_s3_bucket.archive_target.bucket
}

output "aws_kms_key" {
  description = "The KMS Key ID of the KMS key that was created."
  value       = aws_kms_key.rubrik-cloudout.key_id
}
output "aws_region" {
  description = "The AWS region where the resoruces were created."
  value       = var.region
}