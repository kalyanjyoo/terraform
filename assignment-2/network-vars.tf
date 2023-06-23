# VPC Input Variables

# VPC Name
variable "vpc-name" {
  description = "this variable having vpc tagname"
  type = string 
  default = "eks-vpc"
}

# VPC CIDR Block
variable "vpc-cidr-block" {
  description = "VPC CIDR Block"
  type = string 
  default = "10.0.0.0/16"
}

# VPC Public Subnets
variable "vpc-public-subnets" {
  description = "VPC Public Subnets"
  type = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

# VPC Private Subnets
variable "vpc-private-subnets" {
  description = "VPC Private Subnets"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "subnet-pvt-region-1" {
    description = "this variable having private subnet -1 region"
    type = string
    default = "ap-south-1a"
  }

variable "subnet-pvt-region-2" {
    description = "this variable having private subnet -2 region"
    type = string
    default = "ap-south-1b"
  }

variable "subnet-pub-region-1" {
    description = "this variable having public subnet -1 region"
    type = string
    default = "ap-south-1a"
  }

variable "subnet-pub-region-2" {
    description = "this variable having public subnet -2 region"
    type = string
    default = "ap-south-1b"
  }

variable "subnet-tag-pvt-1a" {
    description = "this variable having subnet private 1a tagname"
    type = string
    default = "eks-private-subnet-1a"
  }

variable "subnet-tag-pvt-1b" {
    description = "this variable having subnet private 1b tagname"
    type = string
    default = "eks-private-subnet-1b"
  }

variable "subnet-tag-pub-1a" {
    description = "this variable having subnet public 1a tagname"
    type = string
    default = "eks-public-subnet-1a"
  }

variable "subnet-tag-pub-1b" {
    description = "this variable having subnet public 1btagname"
    type = string
    default = "eks-public-subnet-1b"
  }

variable "igw-tag-name" {
    description = "this variable having igw tagname"
    type = string
    default = "eks-igw"
  }

variable "eip-tag-name" {
    description = "this variable having eip tagname"
    type = string
    default = "eks-eip"
  }

variable "nat-tag-name" {
    description = "this variable having nat tagname"
    type = string
    default = "eks-nat"
  }

variable "rt-pvt-tag-name" {
    description = "this variable having rt-private tagname"
    type = string
    default = "rt-private"
  }

variable "rt-pub-tag-name" {
    description = "this variable having rt-public tagname"
    type = string
    default = "rt-public"
  }

variable "rt-pvt-cidr-block" {
    description = "this variable having rt-private cidr block"
    type = string
    default = "0.0.0.0/0"
  }

variable "rt-pub-tag-name" {
    description = "this variable having rt-private cidr block"
    type = string
    default = "0.0.0.0/0"
  }


