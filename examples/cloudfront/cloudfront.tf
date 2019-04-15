provider "aws" {
  region = "ap-southeast-1"
}

module "testcloudfront" {
  source              = "../../modules/cloudfront"
  access_log_bucket   = "test-bucket-cloudfront2"
  aws_region          = "ap-southeast-1"
  waf_whitelist_ipset = [
    {value = "1.1.1.1/32", type="IPV4"},
    {value = "2.2.2.2/32", type="IPV4"},
    ]
  waf_blacklist_ipset = [
    {value = "3.3.3.3/32", type="IPV4"},
    ]
}
