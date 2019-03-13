provider "aws" {
  region = "ap-southeast-1"
}

module "name" {
  source              = "../modules/cloudfront"
  access_log_bucket   = "${var.access_log_bucket}"
  lambda_files_bucket = "testdfsd222222"
  aws_region          = "${var.aws_region}"
}
