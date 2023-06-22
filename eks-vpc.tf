# Resource Block
# Resource-1: Create VPC
resource "aws_vpc" "vpc-dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "eks-vpc"
  }
}

# Resource-2: Create private Subnets in 1a
resource "aws_subnet" "private-subnet-1a" {
  vpc_id = aws_vpc.vpc-dev.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    "Name" = "eks-private-subnet-1a"
  }
}

# Resource-3: Create private Subnets in 1b
resource "aws_subnet" "private-subnet-1b" {
  vpc_id = aws_vpc.vpc-dev.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    "Name" = "eks-private-subnet-1b"
  }
}

# Resource-4: Create public Subnets in 1a
resource "aws_subnet" "public-subnet-1a" {
  vpc_id = aws_vpc.vpc-dev.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "eks-public-subnet-1a"
  }
}

# Resource-5: Create public Subnets in 1b
resource "aws_subnet" "public-subnet-1b" {
  vpc_id = aws_vpc.vpc-dev.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "eks-public-subnet-1b"
  }
}

# Resource-6: Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-dev.id
  tags = {
    "Name" = "eks-igw"
  }
}

# Resource-7: elasticip 
resource "aws_eip" "eip" {
    vpc = true
    tags = {
      "Name" = "eks-eip"
    }
}

# Resource -8: Nat Gateway
resource "aws_nat_gateway" "nat-gw" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public-subnet-1a.id
    tags = {
      "Name" = "eks-nat"
    }
    depends_on = [ aws_internet_gateway.igw ]
  
}

# Resource-9: Create Route Table for private
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc-dev.id
  tags = {
    "Name" = "rt-private"
  }
}

# Resource-10: Create Route in Route Table for private
resource "aws_route" "private-route" {
  route_table_id = aws_route_table.private-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat-gw.id
}

# Resource-11: create route table for public
resource "aws_route_table" "public-route-table" {
    vpc_id = aws_vpc.vpc-dev.id
    tags = {
      "Name" = "rt-public"
    } 
}

# Resource-12: Create Route in Route Table for public
resource "aws_route" "public-route" {
  route_table_id = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}


# Resource-6: Associate the Route Table with the  private Subnet
resource "aws_route_table_association" "private-rt-associate-1a" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id = aws_subnet.private-subnet-1a.id
}


# Resource-6: Associate the Route Table with the private Subnet
resource "aws_route_table_association" "private-rt-associate-1b" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id = aws_subnet.private-subnet-1b.id
}


# Resource-6: Associate the Route Table with the public Subnet
resource "aws_route_table_association" "public-rt-associate-1a" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id = aws_subnet.public-subnet-1a.id
}


# Resource-6: Associate the Route Table with the public Subnet
resource "aws_route_table_association" "public-rt-associate-1b" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id = aws_subnet.public-subnet-1b.id
}
