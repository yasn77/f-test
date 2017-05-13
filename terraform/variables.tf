variable "access_key" {}
variable "secret_key" {}
variable "sshpubkey_file" {
  default = "sshpub.key"
}
variable "region" {
  default = "us-east-1"
}
variable "ami_id" {
  default = "ami-80861296"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "app_instance_count" {
  default = "3"
}
variable "cidr_block" {
  default = "10.10.0.0/16"
}
variable "app_subnet_id" {
  default = "10.10.19.0/24"
}

variable "jumphost_subnet_id" {
  default = "10.10.22.0/24"
}
