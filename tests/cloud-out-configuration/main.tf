data "local_file" "random-number" {
  filename = "../random-number"
}

data "aws_instance" "cloud-cluster" {
  filter {
    name   = "tag:Name"
    values = ["terraform-module-cloud-out-testing-${data.local_file.random-number.content}-1"]
  }
}

provider "rubrik" {
  node_ip  = "${data.aws_instance.cloud-cluster.private_ip}"
  username = "admin"
  password = "RubrikGoForward"
}

module "rubrik-s3-cloudout" {
  source               = "../.."
  bucket_name          = "tf-module-cloudout-test-${data.local_file.random-number.content}"
  archive_name         = "S3:TerraformCloudOutModule"
  bucket_force_destory = true
  iam_user_name        = "tf-module-cloudout-test-user-${data.local_file.random-number.content}"
  iam_policy_name      = "tf-module-cloudout-test-policy-${data.local_file.random-number.content}"
  kms_key_alias        = "tf-module-cloudout-test-policy-kms-${data.local_file.random-number.content}"
}
