# VPC Output Values

# VPC CIDR blocks
output "vpc-cidr-block" {
  description = "The CIDR block of the VPC"
  value       = "${aws_vpc.vpc-dev.cidr_block}"
}

# VPC Public Subnets
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = "${aws_subnet.public.*.id}"
}
