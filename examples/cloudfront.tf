provider "aws" {
  region = "ap-southeast-1"
}

module "testmodule" {
  source            = "../modules/cloudfront"
  access_log_bucket = "${var.access_log_bucket}"
  aws_region        = "${var.aws_region}"
}
