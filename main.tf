provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.profile}"
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name        = "${var.name}"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${element(keys (var.public_subnets), count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  count             = "${length(var.public_subnets)}"

 tags {
    Name        = "${format("%s-%s-public-%s-%d", var.name, lookup(var.public_subnets, element(keys(var.public_subnets), count.index)), element(split("-", element(var.availability_zones, count.index)),2), count.index+1)}"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${var.vpc_id}"
  count  = "${length(var.public_subnets)}"

  tags {
    Name         = "${format("%s-%s-rt-public-%s-%d", var.name, lookup(var.public_subnets, element(keys(var.public_subnets), count.index)), element(split("-", element(var.availability_zones, count.index)),2), count.index+1)}"
    AZ           = "${element(var.availability_zones, count.index)}"
    Environment = "${var.environment}"
  }
}

resource "aws_route" "public" {
  route_table_id         = "${element(aws_route_table.public.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"
  count  = "${length(var.public_subnets)}"
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
}
