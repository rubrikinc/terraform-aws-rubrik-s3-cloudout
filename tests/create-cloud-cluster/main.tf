# Terraform Configuration used for full integration test

resource "random_id" "r" {
  byte_length = 1
}

resource "local_file" "random-number" {
  content  = "${random_id.r.dec}"
  filename = "../random-number"
}

variable "aws_vpc_security_group_ids" {
  type = "list"
}

variable "aws_subnet_id" {}

module "rubrik_aws_cloud_cluster" {
  source = "rubrikinc/rubrik-cloud-cluster/aws"

  aws_disable_api_termination = false
  aws_vpc_security_group_ids  = "${var.aws_vpc_security_group_ids}"
  aws_subnet_id               = "${var.aws_subnet_id}"
  cluster_name                = "terraform-module-cloud-out-testing-${random_id.r.dec}"
  admin_email                 = "build@rubrik.com"
  dns_search_domain           = ["rubrikbuild.com"]
  dns_name_servers            = ["8.8.8.8"]
}
