provider "aws" {
  region = "ap-southeast-1"
}

module "testcloudfront" {
  source                                    = "../../modules/cloudfront"
  access_log_bucket                         = "test-bucket-cloudfront"
  aws_region                                = "ap-southeast-1"
}
