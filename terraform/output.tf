output "address" {
    value = "${aws_instance.sample.private_ip}"
}
output "elastic ip" {
    value = "${aws_eip.sample.public_ip}"
}
