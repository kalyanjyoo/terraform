# Resource Block
# Resource-1: Create VPC
resource "aws_vpc" "vpc-dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "vpc-dev"
  }
}

# Resource-2: Create Subnets
resource "aws_subnet" "vpc-dev-public-subnet-1" {
  vpc_id = aws_vpc.vpc-dev.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "subnet-dev"
  }
}

# Resource-3: Internet Gateway
resource "aws_internet_gateway" "vpc-dev-igw" {
  vpc_id = aws_vpc.vpc-dev.id
  tags = {
    "Name" = "igw-dev"
  }
}

# Resource-4: Create Route Table
resource "aws_route_table" "vpc-dev-public-route-table" {
  vpc_id = aws_vpc.vpc-dev.id
  tags = {
    "Name" = "rt-dev"
  }
}

# Resource-5: Create Route in Route Table for Internet Access
resource "aws_route" "vpc-dev-public-route" {
  route_table_id = aws_route_table.vpc-dev-public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.vpc-dev-igw.id
}


# Resource-6: Associate the Route Table with the Subnet
resource "aws_route_table_association" "vpc-dev-public-route-table-associate" {
  route_table_id = aws_route_table.vpc-dev-public-route-table.id
  subnet_id = aws_subnet.vpc-dev-public-subnet-1.id
}

# Resource-7: Create Security Group
resource "aws_security_group" "dev-vpc-sg" {
  name = "dev-vpc-default-sg"
  vpc_id = aws_vpc.vpc-dev.id
  description = "Dev VPC Default Security Group"
  tags = {
    "Name" = "web-sg"
  }

  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Resource-8: Create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami = "ami-057752b3f1d6c4d6c" # Amazon Linux
  instance_type = "t2.micro"
  subnet_id = aws_subnet.vpc-dev-public-subnet-1.id
  key_name = "pemkey"
  user_data = "${file("apache-install.sh")}"
  vpc_security_group_ids = [ aws_security_group.dev-vpc-sg.id ]
  tags = {
    "Name" = "web"
  }
}

# Resource-9: Create Elastic IP
resource "aws_eip" "my-eip" {

}

# Resource-10: Elastic IP Allocation
resource "aws_eip_association" "my-eip-allocation" {
    instance_id = aws_instance.my-ec2-vm.id
    allocation_id = aws_eip.my-eip.id
}

