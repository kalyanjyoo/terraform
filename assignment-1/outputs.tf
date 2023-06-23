output "awsinstancepublicip" {
    description = "the public ip address of ec2 instance"
    value = "${aws_instance.my-ec2-vm.public_ip}"
}

output "awsinstanceprivateip" {
    description = "the private ip address of ec2 instance"
    value = "${aws_instance.my-ec2-vm.private_ip}"
}

output "awsinstanceami" {
    description = "the ami of ec2 instance"
    value = "${aws_instance.my-ec2-vm.ami}"
}

output "awsinstanceaz" {
    description = "the availability zone of ec2 instance"
    value = "${aws_instance.my-ec2-vm.availability_zone}"
}

output "awsinstancekeyname" {
    description = "the keynameof ec2 instance"
    value = "${aws_instance.my-ec2-vm.key_name}"
}