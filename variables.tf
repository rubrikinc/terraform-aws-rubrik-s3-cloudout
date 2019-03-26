variable "bucket_name" {
  description = "The name of the S3 bucket to use as an archive target."
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
  description = "The name of the IAM Policy configured with the correct CloudOut permissions"
  default     = "rubrik-cloudout"
}
