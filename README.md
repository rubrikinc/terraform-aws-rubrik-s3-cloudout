# terraform-aws-s3-rubrik-cloudout

Terraform module that configures an AWS S3 archive target and adds that target to the Rubrik cluster. The following steps are completed by the module:

* Create a new AWS S3 Bucket
* Create a new user specific to Rubrik
* Create a new IAM Policy with the correct permissions and attached to the new user.
* Create a new KMS Key to use for encryption
* Adds the S3 Bucket to the Rubrik cluster as an archival location

## Documentation

Here are some resources to get you started! If you find any challenges from this project are not properly documented or are unclear, please raise an issueand let us know! This is a fun, safe environment - don't worry if you're a GitHub newbie!

* [Quick Start Guide](/docs/quick-start.md)
* [Rubrik API Documentation](https://github.com/rubrikinc/api-documentation)

### Usage

```hcl
module "rubrik_aws_cloud_cluster" {
  source  = "rubrikinc/aws-s3-rubrik-cloudout/module"

  bucket_name  = "rubrik-tf-module-bucket"
  archive_name = "S3:ArchiveLocation"
}
```

## Inputs

The following are the variables accepted by the module.

| Name                 | Description                                                                                                               |  Type  |      Default     | Required |
|----------------------|---------------------------------------------------------------------------------------------------------------------------|:------:|:----------------:|:--------:|
| bucket_name          | The name of the S3 bucket to use as an archive target.                                                                    | string |                  |    yes   |
| archive_name         | The name of the Rubrik archive location in the Rubrik GUI.                                                                | string |                  |    yes   |
| bucket_force_destory | A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. |  bool  |       false      |    no    |
| storage_class        | The storage class of the S3 Bucket. Valid choices are standard, standard_ia, and reduced_redundancy.                      | string |     standard     |    no    |
| iam_user_name        | The name of the IAM User to create.                                                                                       | string |      rubrik      |    no    |
| iam_policy_name      | The name of the IAM Policy configured with the correct CloudOut permissions.                                              | string | rubrik-cloud-out |    no    |
| kms_key_alias        | The alias for the KMS Key ID.                                                                                             | string | rubrik-cloud-out |    no    |

| WARNING: The new IAM User Secret key is stored in plaintext in the `terraform.tfstate` file. Please ensure this file is stored properly.  |
| --- |



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

We'd  love to hear from you! Email us: build@rubrik.com 
