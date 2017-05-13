data "aws_availability_zones" "available" {}

data "template_file" "app-cloud-init" {
  template = "${file("app_cloud-config.tpl")}"

  vars {
    role = "app"
  }

}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_key_pair" "auth" {
  public_key = "${file(var.sshpubkey_file)}"
}


resource "aws_elb" "f_test_app_elb" {
  name = "yasser-f-test-app-elb"

  subnets = ["${aws_subnet.app_subnet.id}"]
  security_groups  = ["${aws_security_group.f_test_elb.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

resource "aws_autoscaling_group" "f_test_app" {
  vpc_zone_identifier  = ["${aws_subnet.app_subnet.id}"]
  max_size             = "5"
  min_size             = "${var.app_instance_count}"
  desired_capacity     = "${var.app_instance_count}"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.f_test_app.name}"
  load_balancers       = ["${aws_elb.f_test_app_elb.name}"]

  tag {
    key                 = "Name"
    value               = "yasser_f_test_app"
    propagate_at_launch = "true"
  }
  tag {
    key                 = "Role"
    value               = "f_test_app"
    propagate_at_launch = "true"
  }
  tag {
    key                 = "project"
    value               = "f_test"
    propagate_at_launch = "true"
  }
}

resource "aws_launch_configuration" "f_test_app" {
  image_id      = "${var.ami_id}"
  instance_type = "${var.instance_type}"

  security_groups =["${aws_security_group.f_test_app.id}"]
  user_data       = "${data.template_file.app-cloud-init.rendered}"
  key_name        = "${aws_key_pair.auth.id}"
  iam_instance_profile = "${aws_iam_instance_profile.f_test_app_profile.name}"
}

module "f_test_jumphost" {
  source = "modules/f_test_instance"
  ami_id = "${var.ami_id}"
  key_name = "${aws_key_pair.auth.id}"
  vpc_security_group_ids = ["${aws_security_group.f_test_jumphost.id}"]
  instance_count = "1"
  instance_type = "${var.instance_type}"
  tags = {
    role = "jumphost",
    Name = "yasser_jumphost_f_test"
  }
  subnet_id = "${aws_subnet.jumphost_subnet.id}"
}
