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

variable "public-subnet-cidrs" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "private-subnet-cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}


variable "subnet-tag-pvt" {
    description = "this variable having subnet private 1a tagname"
    type = string
    default = "eks-private-subnet"
  }

variable "subnet-tag-pub" {
    description = "this variable having subnet private 1b tagname"
    type = string
    default = "eks-public-subnet"
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

variable "rt-pub-cidr-block" {
    description = "this variable having rt-private cidr block"
    type = string
    default = "0.0.0.0/0"
  }


