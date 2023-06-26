# EKS Cluster Input Variables
variable "cluster-name" {
    description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
    type = string
    default = "eks-cluster"
  }

variable "cluster-version" {
    description = "Kubernetes minor version to use for the EKS cluster (for example 1.21)"
    type = string
    default = "1.25"
  }

variable "cluster-endpoint-public-access" {
    description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. When it's set to `false` ensure to have a proper private access with `cluster_endpoint_private_access = true`."
    type        = bool
    default     = true
  }

variable "cluster-endpoint-public-access-cidrs" {
    description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
    type        = list(string)
    default     = ["0.0.0.0/0"]
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

