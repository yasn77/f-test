resource "aws_vpc" "f_test" {
  cidr_block = "${var.cidr_block}"
  enable_dns_hostnames = true
  tags {
        Name = "yasser_f_test_vpc"
  }
}

resource "aws_internet_gateway" "f_test" {
  vpc_id = "${aws_vpc.f_test.id}"
  tags {
        Name = "yasser_f_test_gw"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.f_test.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.f_test.id}"
}

resource "aws_subnet" "app_subnet" {
  vpc_id                  = "${aws_vpc.f_test.id}"
  cidr_block              = "${var.app_subnet_id}"
  map_public_ip_on_launch = false
  tags {
        Name = "yasser_app_subnet"
  }
}

resource "aws_subnet" "jumphost_subnet" {
  vpc_id                  = "${aws_vpc.f_test.id}"
  cidr_block              = "${var.jumphost_subnet_id}"
  map_public_ip_on_launch = true
  tags {
        Name = "yasser_jumphost_subnet"
  }
}
