resource "local_file" "iam_credentials" {
  content  = "IAM User Access Key: ${aws_iam_access_key.rubrik-user.id}\nIAM User Secret Key: ${aws_iam_access_key.rubrik-user.secret}\n"
  filename = "iam_keys.txt"
  file_permission = "0600"
}