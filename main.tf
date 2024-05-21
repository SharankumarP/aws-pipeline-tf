resource "aws_s3_bucket" "s3_test_bucket_backend" {
  #checkov:skip=CKV_AWS_145: Lifecycle configuration not required for TF state bucket
  #checkov:skip=CKV2_AWS_61: Lifecycle configuration not required for TF state bucket
  #checkov:skip=CKV_AWS_144: Cross-region replication not required for TF state bucket
  #checkov:skip=CKV2_AWS_62: Event notifications not required for TF state bucket
  #checkov:skip=CKV_AWS_145: No KMS encryption needed for TF state bucket
  #checkov:skip=CKV_AWS_21: No versioning needed for TF state bucket
  #checkov:skip=CKV_AWS_18: No logging needed for TF state bucket
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_acl" "s3_test_bucket_backend_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
  bucket     = aws_s3_bucket.s3_bucket_backend.id
  acl        = "private"
}

resource "aws_s3_bucket_ownership_controls" "s3_test_bucket_acl_ownership" {
  bucket = aws_s3_bucket.s3_bucket_backend.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_versioning" "s3_test_bucket_version" {
  bucket = aws_s3_bucket.s3_bucket_backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_test_object" "terraform_folder" {
  bucket = aws_s3_bucket.s3_bucket_backend.id
  key    = "terraform.tfstate"
}

resource "aws_s3_bucket_public_access_block" "s3_test_bucket_access" {
  bucket                  = aws_s3_bucket.s3_bucket_backend.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
