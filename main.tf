provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.profile}"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name        = "${var.name}"
    Environment = "${var.environment}"
  }
}
