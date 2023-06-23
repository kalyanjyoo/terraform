# Resource Block
# Resource-1: Create VPC
resource "aws_vpc" "vpc-dev" {
  cidr_block = "${var.vpc-cidr-block}"
  tags = {
    "Name" = "${var.vpc-name}"
  }
}

# Resource-2: Create private Subnets in 1a
resource "aws_subnet" "private-subnet-1a" {
  vpc_id = aws_vpc.vpc-dev.id
  cidr_block = "${var.vpc-private-subnets}"
  availability_zone = "${var.subnet-pvt-region-1}"
  tags = {
    "Name" = "${var.subnet-tag-pvt-1a}"
  }
}

# Resource-3: Create private Subnets in 1b
resource "aws_subnet" "private-subnet-1b" {
  vpc_id = aws_vpc.vpc-dev.id
  cidr_block = "${var.vpc-private-subnets}"
  availability_zone = "${var.subnet-pvt-region-2}"
  tags = {
    "Name" = "${var.subnet-tag-pvt-1b}"
  }
}

# Resource-4: Create public Subnets in 1a
resource "aws_subnet" "public-subnet-1a" {
  vpc_id = aws_vpc.vpc-dev.id
  cidr_block = "${var.vpc-public-subnets}"
  availability_zone = "${var.subnet-pub-region-1}"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.subnet-tag-pub-1a}"
  }
}

# Resource-5: Create public Subnets in 1b
resource "aws_subnet" "public-subnet-1b" {
  vpc_id = aws_vpc.vpc-dev.id
  cidr_block = "${var.vpc-public-subnets}"
  availability_zone = "${var.subnet-pub-region-2}"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.subnet-tag-pub-1b}"
  }
}

# Resource-6: Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-dev.id
  tags = {
    "Name" = "${var.igw-tag-name}"
  }
}

# Resource-7: elasticip 
resource "aws_eip" "eip" {
    vpc = true
    tags = {
      "Name" = "${var.eip-tag-name}"
    }
}

# Resource -8: Nat Gateway
resource "aws_nat_gateway" "nat-gw" {
    allocation_id = aws_eip.eip.id
    subnet_id = aws_subnet.public-subnet-1a.id
    tags = {
      "Name" = "${var.nat-tag-name}"
    }
    depends_on = [ aws_internet_gateway.igw ]
  
}

# Resource-9: Create Route Table for private
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc-dev.id
  tags = {
    "Name" = "${var.rt-pvt-tag-name}"
  }
}

# Resource-10: Create Route in Route Table for private
resource "aws_route" "private-route" {
  route_table_id = aws_route_table.private-route-table.id
  destination_cidr_block = "${var.rt-pvt-cidr-block}"
  nat_gateway_id = aws_nat_gateway.nat-gw.id
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


# Resource-13: Associate the Route Table with the  private Subnet
resource "aws_route_table_association" "private-rt-associate-1a" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id = aws_subnet.private-subnet-1a.id
}


# Resource-14: Associate the Route Table with the private Subnet
resource "aws_route_table_association" "private-rt-associate-1b" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id = aws_subnet.private-subnet-1b.id
}


# Resource-15: Associate the Route Table with the public Subnet
resource "aws_route_table_association" "public-rt-associate-1a" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id = aws_subnet.public-subnet-1a.id
}


# Resource-16: Associate the Route Table with the public Subnet
resource "aws_route_table_association" "public-rt-associate-1b" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id = aws_subnet.public-subnet-1b.id
}
