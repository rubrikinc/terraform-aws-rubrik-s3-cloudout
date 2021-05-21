variable "aws_region" {
  description = "The region to create resoruces for Rubrik CloudOut."
}

variable "bucket_name" {
  description = "The name of the S3 bucket to use as an archive target."
}

variable "bucket_force_destory" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error."
  default     = false
}

variable "storage_class" {
  description = "The storage class of the S3 Bucket."
  default     = "standard"
}

variable "archive_name" {
  description = "The name of the Rubrik archive location in the Rubrik GUI."
}

variable "iam_user_name" {
  description = "The name of the IAM User to create."
  default     = "rubrik"
}

variable "iam_policy_name" {
  description = "The name of the IAM Policy configured with the correct CloudOut permissions."
  default     = "rubrik-cloud-out"
}

variable "kms_key_alias" {
  description = "The alias for the KMS Key ID."
  default     = "rubrik-cloud-out"
}

variable "timeout" {
  description = "The number of seconds to wait to establish a connection the Rubrik cluster before returning a timeout error."
  default     = 120
}

variable "save_keys" {
  description = "When set to true, access and secret keys for the newly created IAM account will be saved in iam_keys.txt"
  default     = false
}
