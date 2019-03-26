terraform {
  required_version = ">= 0.10.3" # introduction of Local Values configuration language feature
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_s3_bucket" "rubrik_s3_archive_target" {
  bucket = "${var.bucket_name}"
}

resource "aws_iam_user" "rubrik-iam-user" {
  name = "${var.iam_user_name}"
}

resource "aws_iam_policy" "rubrik-iam-policy" {
  name = "${var.iam_policy_name}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:CreateBucket",
                "s3:ListAllMyBuckets"
            ],
            "Resource": "arn:aws:s3:::*"
        },

         {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": "arn:aws:s3:::${var.bucket_name}",
        },

        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:AbortMultipartUpload",
                "s3:ListMultipartUploadParts",
                "s3:RestoreObject"
            ],
            "Resource": "arn:aws:s3:::${var.bucket_name}/*",
        }
    ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "rubrik-iam-cloudout" {
  user       = "${aws_iam_user.rubrik-iam-user.name}"
  policy_arn = "${aws_iam_policy.rubrik-iam-policy.arn}"
}

resource "aws_kms_key" "rubrik-cloudout" {
  description = "KMS Key for Rubrik CloudOut."

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "key-consolepolicy-3",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
      "Sid": "Allow access for Key Administrators",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_user.rubrik-iam-user.arn}"
      },
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "*"
    },
    {
      "Sid": "Allow use of the key",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_user.rubrik-iam-user.arn}"
      },
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "*"
    }
    }
  ]
} EOF
}

resource "rubrik_aws_s3_cloudout" "s3-archive-target" {
  aws_bucket    = "${aws_s3_bucket.rubrik_s3_archive_target.bucket}"
  storage_class = "${var.storage_class}"
  archive_name  = "${var.archive_name}"
  aws_region    = "${data.aws_region.current.name}"

  # rsa_key           = "${tls_private_key.rsa-key.private_key_pem}"
  kms_master_key_id = "${aws_kms_key.rubrik-cloudout.key_id}"
}
