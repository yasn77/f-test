output "id_list" {
  value = ["${aws_instance.f_test.*.id}"]
}

output "dns_list" {
  value = ["${aws_instance.f_test.*.public_dns}"]
}

