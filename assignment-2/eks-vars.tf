# EKS Cluster Input Variables
variable "cluster-name" {
    description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
    type = string
    default = "eks-cluster"
  }

variable "iamrole-cluster" {
    description = "this variable having iamrole for cluster."
    type = string
    default = "eks-cluster"
  }

variable "iamrole-nodegroup" {
    description = "this variable having iamrole for nodegroup."
    type = string
    default = "eks-nodegroup"
  }

