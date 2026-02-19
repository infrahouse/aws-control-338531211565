provider "aws" {
  region = "us-west-1"
  assume_role {
    role_arn = "arn:aws:iam::338531211565:role/ih-tf-aws-control-338531211565-admin"
  }
  default_tags {
    tags = {
      "created_by" : "infrahouse/aws-control-338531211565"
    }
  }
}