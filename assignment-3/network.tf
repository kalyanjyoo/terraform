# Resource Block
# Resource-1: Create VPC
resource "aws_vpc" "vpc-dev" {
  cidr_block = "${var.vpc-cidr-block}"
  tags = {
    "Name" = "${var.vpc-name}"
  }
}

# Resource-2: Create private Subnets in 1a
resource "aws_subnet" "private" {
  count             = length(var.private-subnet-cidrs)
  vpc_id = aws_vpc.vpc-dev.id
  cidr_block              = element(var.private-subnet-cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = {
    "Name" = "${var.subnet-tag-pvt}"
  }
}


# Resource-4: Create public Subnets in 1a
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
    subnet_id = aws_subnet.public[0].id
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
resource "aws_route_table_association" "private-rt-associate" {
  count          = length(var.private-subnet-cidrs)
  route_table_id = aws_route_table.private-route-table.id
  subnet_id = aws_subnet.private[count.index].id
}

# Resource-14: Associate the Route Table with the public Subnet
resource "aws_route_table_association" "public-rt-associate" {
  count          = length(var.private-subnet-cidrs)
  route_table_id = aws_route_table.public-route-table.id
  subnet_id = aws_subnet.public[count.index].id
}
