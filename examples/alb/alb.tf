provider "aws" {
  region = "ap-southeast-1"
}

module "testalb" {
  source                                    = "../../modules/alb"
  access_log_bucket                         = "test-bucket-alb2"
  aws_region                                = "ap-southeast-1"
}
