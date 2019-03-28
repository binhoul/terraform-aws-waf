provider "aws" {
  region = "ap-southeast-1"
}

module "testcloudfront" {
  source                                    = "../../modules/cloudfront"
  access_log_bucket                         = "test-bucket-cloudfront"
  aws_region                                = "ap-southeast-1"
  sql_injection_protection_activated        = "yes"
  cross_site_scripting_protection_activated = "yes"
  http_flood_protection_activated           = "yes"
  scanner_probe_protection_activated        = "yes"
  reputation_lists_protection_activated     = "yes"
  bad_bot_protection_activated              = "yes"
}
