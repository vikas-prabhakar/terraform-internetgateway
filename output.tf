output "igw_id" {
 value = "${aws_internet_gateway.internet_gateway.id}"
}

output "subnet_id" {
value = "${aws_subnet.public.*.id}"
}
