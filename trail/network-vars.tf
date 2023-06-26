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

variable "rt-pub-tag-name" {
    description = "this variable having rt-public tagname"
    type = string
    default = "rt-public"
  }

variable "rt-pub-cidr-block" {
    description = "this variable having rt-private cidr block"
    type = string
    default = "0.0.0.0/0"
  }


