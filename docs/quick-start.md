# Quick Start: Rubrik AWS S3 CloudOut Deployment Terraform Module

Configure an AWS S3 archive target and add that target to the Rubrik cluster. The following steps are completed by the module:

- Create a new AWS S3 Bucket
- Create a new user specific to Rubrik
- Create a new IAM Policy with the correct permissions and attached to the new user
- Create a new KMS Key to use for encryption
- Configure a Rubrik cluster to use the new S3 Bucket as an archival location

Completing the steps detailed below will require that Terraform is installed and in your environment path, that you are running the instance from a \*nix shell (bash, zsh, etc).

## Authentication

The following environment variables are used to authenticate to AWS and your Rubrik Cluster.

| Name                  | Description                                                       |
| --------------------- | ----------------------------------------------------------------- |
| AWS_ACCESS_KEY_ID     | IAM Access Key with permissions to create CloudOut resources      |
| AWS_SECRET_ACCESS_KEY | IAM Secret Key for the account above                              |
| rubrik_cdm_node_ip    | IP Address of Rubrik CDM                                          |
| rubrik_cdm_username   | Rubrik CDM account with permissions to configure archive settings |
| rubrik_cdm_password   | Password for Rubrik CDM account above                             |

## Configuration

In your [Terraform configuration](https://learn.hashicorp.com/terraform/getting-started/build#configuration) (`main.tf`) populate the following and update the variables to your specific environment:

```hcl
module "rubrik_aws_cloud_cluster" {
  source = "rubrikinc/rubrik-s3-cloudout/aws"

  aws_region   = "us-east-1"
  bucket_name  = "rubrik-tf-module-bucket"
  archive_name = "S3:ArchiveLocation"
}
```

You may also add additional variables, such as `storage_class`, to overwrite the default values.

## Inputs

The following are the variables accepted by the module.

| Name                 | Description                                                                                                           |  Type  |     Default      | Required |
| -------------------- | --------------------------------------------------------------------------------------------------------------------- | :----: | :--------------: | :------: |
| aws_region           | Region to create S3 bucket in                                                                                         | string |                  |   yes    |
| bucket_name          | The name of the S3 bucket to use as an archive target.                                                                | string |                  |   yes    |
| archive_name         | The name of the Rubrik archive location in the Rubrik GUI.                                                            | string |                  |   yes    |
| bucket_force_destory | When true, indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. |  bool  |      false       |    no    |
| save_keys            | When true, save a copy of created IAM Access and Secret keys in iam_keys.txt.                                         |  bool  |      false       |    no    |
| storage_class        | The storage class of the S3 Bucket. Valid choices are standard, standard_ia, and reduced_redundancy.                  | string |     standard     |    no    |
| iam_user_name        | The name of the IAM User to create.                                                                                   | string |      rubrik      |    no    |
| iam_policy_name      | The name of the IAM Policy configured with the correct CloudOut permissions.                                          | string | rubrik-cloud-out |    no    |
| kms_key_alias        | The alias for the KMS Key ID.                                                                                         | string | rubrik-cloud-out |    no    |
| timeout              | The number of seconds to wait to establish a connection the Rubrik cluster before returning a timeout error.          |  int   |       120        |    no    |

| WARNING: The new IAM User Secret key is stored in plaintext in the `terraform.tfstate` file. Please ensure this file is stored properly. |
| ---------------------------------------------------------------------------------------------------------------------------------------- |

| WARNING: If saved, iam_keys.txt contains IAM keys stored in plaintext. Save the contents in a secure location and remove the file. |
| ---------------------------------------------------------------------------------------------------------------------------------- |

## Outputs

The following are the variables outputed by the module.

| Name                | Description                                                     |
| ------------------- | --------------------------------------------------------------- |
| aws_iam_user_name   | The name of the AWS IAM User created.                           |
| rubrik_archive_name | he name of the archival location created on the Rubrik cluster. |

## Running the Terraform Configuration

This section outlines what is required to run the configuration defined above.

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) v0.15.4 or greater
- [Rubrik Provider for Terraform](https://github.com/rubrikinc/rubrik-provider-for-terraform) - provides Terraform functions for Rubrik

### Initialize the Directory

The directory can be initialized for Terraform use by running the `terraform init` command:

```none
Initializing modules...
- module.rubrik-s3-cloudout
  Getting source = "rubrikinc/rubrik-s3-cloudout/aws"

Initializing provider plugins...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 2.2"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

### Gain Access to the Rubrik Cloud Cluster AMI

### Planning

Run `terraform plan` to get information about what will happen when we apply the configuration; this will test that everything is set up correctly.

### Applying

We can now apply the configuration to create the necessary resources in AWS. After AWS is configured, a new Archive Location will be added to your Rubrik cluster.

### Destroying

If the Archive Location is no longer required, it can be destroyed using the `terraform destroy` command, and entering `yes` when prompted. This will remove the S3 bucket and associated AWS resources. **This is a permanent operation and there will be no way to recover your archived backups if the S3 bucket is removed.**
