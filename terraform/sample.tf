provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

# Create a VPC to launch our instances into
resource "aws_vpc" "default" {
    cidr_block = "172.16.0.0/16"
}

resource "aws_key_pair" "sample" {
    key_name   = "${var.key_name}"
    public_key = "${file(var.public_key_path)}"
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
    route_table_id         = "${aws_vpc.default.main_route_table_id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = "${aws_internet_gateway.default.id}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "frontend" {
    vpc_id                  = "${aws_vpc.default.id}"
    cidr_block              = "172.16.1.0/16"
    map_public_ip_on_launch = true
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "frontend" {
    name        = "eip_default"
    description = "Used in the terraform"
    vpc_id      = "${aws_vpc.default.id}"

    # SSH access from anywhere
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # HTTP access from anywhere
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # HTTPS access from anywhere
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # outbound internet access
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "sample" {
    ami                    = "${lookup(var.aws_amis, var.aws_region)}"
    availability_zone      = "eu-west-1a"
    instance_type          = "t2.micro"
    key_name               = "${aws_key_pair.sample.id}"
    subnet_id              = "${aws_subnet.frontend.id}"
    vpc_security_group_ids = ["${aws_security_group.frontend.id}"]
    monitoring             = false
    tags {
        Name = "test"
    }
}

resource "aws_eip" "sample" {
    instance = "${aws_instance.sample.id}"
    vpc      = true
}

resource "aws_ebs_volume" "sample" {
    availability_zone = "eu-west-1a"
    type              = "gp2"
    size              = 10
    tags {
        Name = "sample"
    }
}

resource "aws_volume_attachment" "sample_ebs_att" {
    device_name = "xvdh"
    volume_id   = "${aws_ebs_volume.sample.id}"
    instance_id = "${aws_instance.sample.id}"
}
