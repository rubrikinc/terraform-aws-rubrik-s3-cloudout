resource "local_file" "iam_credentials" {
  content  = "IAM User Access Key: ${aws_iam_access_key.rubrik-user.id}\nIAM User Secret Key: ${aws_iam_access_key.rubrik-user.secret}\n"
  count = var.save_keys ? 1 : 0
  filename = "iam_keys.txt"
  file_permission = "0600"
}