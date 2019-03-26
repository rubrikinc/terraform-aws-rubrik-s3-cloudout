# Quick Start: Rubrik AWS Cloud Cluster Deployment Terraform Module

Completing the steps detailed below will require that Terraform is installed and in your environment path, that you are running the instance from a *nix shell (bash, zsh, etc), and that your machine is allowed HTTPS access through the AWS Security Group, and any Network ACLs, into the instances provisioned.

## Configuration

In your [Terraform configuration](https://learn.hashicorp.com/terraform/getting-started/build#configuration) (`main.tf`) populate the following and update the variables to your specific environment:

```hcl
module "rubrik_aws_cloud_cluster" {
  source  = "rubrikinc/aws-rubrik-cloudout-s3/module"

  bucket_name  = "rubrik-tf-module-bucket"
  archive_name = "S3:ArchiveLocation"
}
```

You may also add additional variables, such as `storage_class`, to overwrite the default values.

## Inputs

The following are the variables accepted by the module.

| Name                 | Description                                                                                                               |  Type  |      Default     | Required |
|----------------------|---------------------------------------------------------------------------------------------------------------------------|:------:|:----------------:|:--------:|
| bucket_name          | The name of the S3 bucket to use as an archive target.                                                                    | string |                  |    yes   |
| archive_name         | The name of the Rubrik archive location in the Rubrik GUI.                                                                | string |                  |    yes   |
| bucket_force_destory | A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. |  bool  |       false      |    no    |
| storage_class        | The storage class of the S3 Bucket.                                                                                       | string |     standard     |    no    |
| iam_user_name        | The name of the IAM User to create.                                                                                       | string |      rubrik      |    no    |
| iam_policy_name      | The name of the IAM Policy configured with the correct CloudOut permissions.                                              | string | rubrik-cloud-out |    no    |
| kms_key_alias        | The alias for the KMS Key ID.                                                                                             | string | rubrik-cloud-out |    no    |

## Running the Terraform Configuration

This section outlines what is required to run the configuration defined above. 

### Prerequisites

* [Terraform](https://www.terraform.io/downloads.html) v0.10.3 or greater
* [Rubrik Provider for Terraform](https://github.com/rubrikinc/rubrik-provider-for-terraform) - provides Terraform functions for Rubrik

### Initialize the Directory

The directory can be initialized for Terraform use by running the `terraform init` command:

```none
Initializing modules...
- module.rubrik_aws_cloud_cluster
  Getting source "rubrikinc/aws-rubrik-cloud-cluster/module"

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

We can now apply the configuration to create the cluster using the `terraform apply` command.

### Destroying

Once the Cloud Cluster is no longer required, it can be destroyed using the `terraform destroy` command, and entering `yes` when prompted. This will also destroy the attached EBS volumes.