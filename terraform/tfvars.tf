/* Variables and defaults */

variable "aws_access_key" {
    default = ""
}

variable "aws_secret_key" {
    default = ""
}

variable "management_ip" {
    default = ""
}

variable "ssh_private_key" {
    default = ""
}

variable "aws_region" {
    default = "us-east-1"
}

variable "ami" {
    default = "ami-82f4dae7"
}

variable "xylophone_version" {
    default = ""
}

variable "keypair_name" {
    default = "deployer"
}
