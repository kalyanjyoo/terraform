# Resource Block
# Resource-1: Create VPC
resource "aws_vpc" "vpc-dev" {
  cidr_block = "${var.vpc-cidr-block}"
  tags = {
    "Name" = "${var.vpc-name}"
  }
}

# Resource-4: Create public Subnets
resource "aws_subnet" "public" {
  count                   = length(var.public-subnet-cidrs)
  vpc_id = aws_vpc.vpc-dev.id
  cidr_block              = element(var.public-subnet-cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.subnet-tag-pub}"
  }
}

# Resource-6: Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-dev.id
  tags = {
    "Name" = "${var.igw-tag-name}"
  }
}

# Resource-11: create route table for public
resource "aws_route_table" "public-route-table" {
    vpc_id = aws_vpc.vpc-dev.id
    tags = {
      "Name" = "${var.rt-pub-tag-name}"
    } 
}

# Resource-12: Create Route in Route Table for public
resource "aws_route" "public-route" {
  route_table_id = aws_route_table.public-route-table.id
  destination_cidr_block = "${var.rt-pub-cidr-block}"
  gateway_id = aws_internet_gateway.igw.id
}


# Resource-14: Associate the Route Table with the public Subnet
resource "aws_route_table_association" "public-rt-associate" {
  count          = length(var.public-subnet-cidrs)
  route_table_id = aws_route_table.public-route-table.id
  subnet_id = aws_subnet.public[count.index].id
}
