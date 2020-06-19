# Terraform Module - AWS Rubrik S3 CloudOut

![AWS CodeBuild Status](https://codebuild.us-west-2.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoibk1JcW1LMFdOYXpNL0c5T052VzRCc0l1SE9BR3BzZkh2bkdlNGxyTzNuUzBOZ2tvZmtWZE1ZbWdrQmplSDJYODVOYnlRc1lDRWhrejI1ZS9aS1ZaZG5zPSIsIml2UGFyYW1ldGVyU3BlYyI6IlNCTzVjWmpXMXlrSHdrNmIiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=master)

Terraform module that configures an AWS S3 archive target and adds that target to the Rubrik cluster. The following steps are completed by the module:

* Create a new AWS S3 Bucket
* Create a new user specific to Rubrik
* Create a new IAM Policy with the correct permissions and attached to the new user
* Create a new KMS Key to use for encryption
* Configure a Rubrik cluster to use the new S3 Bucket as an archival location

## Documentation

Here are some resources to get you started! If you find any challenges from this project are not properly documented or are unclear, please raise an issueand let us know! This is a fun, safe environment - don't worry if you're a GitHub newbie!

* [Quick Start Guide](/docs/quick-start.md)
* [Rubrik API Documentation](https://github.com/rubrikinc/api-documentation)

## Authentication

The following environment variables are used to authenticate to AWS and your Rubrik Cluster.

| Name                  | Description                                                       |
|-----------------------|-------------------------------------------------------------------|
| AWS_ACCESS_KEY_ID     | IAM Access Key with permissions to create CloudOut resources      |
| AWS_SECRET_ACCESS_KEY | IAM Secret Key for the account above                              |
| rubrik_cdm_node_ip    | IP Address of Rubrik CDM                                          |
| rubrik_cdm_username   | Rubrik CDM account with permissions to configure archive settings |
| rubrik_cdm_password   | Password for Rubrik CDM account above                             |

## Usage

```hcl
module "rubrik_aws_cloudout" {
  source = "rubrikinc/rubrik-s3-cloudout/aws"

  aws_region   = "us-east-1"
  bucket_name  = "rubrik-tf-module-bucket"
  archive_name = "S3:ArchiveLocation"
}
```

## Inputs

The following are the variables accepted by the module.

| Name                 | Description                                                                                                               |  Type  |      Default     | Required |
|----------------------|---------------------------------------------------------------------------------------------------------------------------|:------:|:----------------:|:--------:|
| aws_region           | Region to create S3 bucket in                                                                                             | string |                  |    yes   |
| bucket_name          | The name of the S3 bucket to use as an archive target.                                                                    | string |                  |    yes   |
| archive_name         | The name of the Rubrik archive location in the Rubrik GUI.                                                                | string |                  |    yes   |
| bucket_force_destory | When true,  indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. |  bool  |       false      |    no    |
| save_keys            | When true, save a copy of created IAM Access and Secret keys in iam_keys.txt.                                             |  bool  |       false      |    no    |
| storage_class        | The storage class of the S3 Bucket. Valid choices are standard, standard_ia, and reduced_redundancy.                      | string |     standard     |    no    |
| iam_user_name        | The name of the IAM User to create.                                                                                       | string |      rubrik      |    no    |
| iam_policy_name      | The name of the IAM Policy configured with the correct CloudOut permissions.                                              | string | rubrik-cloud-out |    no    |
| kms_key_alias        | The alias for the KMS Key ID.                                                                                             | string | rubrik-cloud-out |    no    |
| timeout              | The number of seconds to wait to establish a connection the Rubrik cluster before returning a timeout error.              |   int  |        120       |    no    |

| WARNING: The new IAM User Secret key is stored in plaintext in the `terraform.tfstate` file. Please ensure this file is stored properly.  |
| --- |

| WARNING: If saved, iam_keys.txt contains IAM keys stored in plaintext. Save the contents in a secure location and remove the file.         |
| --- |

## Outputs

The following are the variables outputed by the module.

| Name                | Description                                                     |
|---------------------|-----------------------------------------------------------------|
| aws_iam_user_name   | The name of the AWS IAM User created.                           |
| rubrik_archive_name | he name of the archival location created on the Rubrik cluster. |



## Prerequisites

There are a few services you'll need in order to get this project off the ground:

* [Terraform](https://www.terraform.io/downloads.html) v0.10.3 or greater
* [Rubrik Provider for Terraform](https://github.com/rubrikinc/rubrik-provider-for-terraform) - provides Terraform functions for Rubrik

## How You Can Help

We glady welcome contributions from the community. From updating the documentation to adding more functions for Python, all ideas are welcome. Thank you in advance for all of your issues, pull requests, and comments! :star:

* [Contributing Guide](CONTRIBUTING.md)
* [Code of Conduct](CODE_OF_CONDUCT.md)

## License

* [MIT License](LICENSE)

## About Rubrik Build

We encourage all contributors to become members. We aim to grow an active, healthy community of contributors, reviewers, and code owners. Learn more in our [Welcome to the Rubrik Build Community](https://github.com/rubrikinc/welcome-to-rubrik-build) page.

We'd love to hear from you! Email us: build@rubrik.com 
