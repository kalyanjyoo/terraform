# EKS Cluster Input Variables
variable "cluster-name" {
    description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
    type = string
    default = "eks-cluster"
  }

variable "cluster_version" {
    description = "Kubernetes minor version to use for the EKS cluster (for example 1.21)"
    type = string
    default     = null
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

