/* Setup AWS provider */
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "us-east-2"
}

/* Security group for the app nodes. */
resource "aws_security_group" "xylophone-app" {
    name = "xylophone-app"
    description = "Security group for the xylophone app instances"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.management_ip}/32"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

/* App nodes are t2.micro running Ubuntu 16.04 LTS */
resource "aws_instance" "xylophone-app" {
  lifecycle {
    create_before_destroy = true
  }
  ami = "${var.ami}"
  instance_type = "t2.micro"
  tags {
    Name = "xylophone-app${count.index}"
    Version = "${var.xylophone_version}"
  }
  count = 1
  associate_public_ip_address = true

  key_name = "${var.keypair_name}"
  security_groups = ["${aws_security_group.xylophone-app.name}"]
}

/* EIP for app server */
resource "aws_eip" "xylophone-app" {
  instance = "${aws_instance.xylophone-app.id}"
}

/* Output the resulting EIP */
output "xylophone-app-eip" {
  value = "${aws_eip.xylophone-app.public_ip}"
}
