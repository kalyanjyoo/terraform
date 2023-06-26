# Define Local Values in Terraform
locals {
  owners = var.business-divsion
  environment = var.environment
  name = "${var.business-divsion}-${var.environment}"
  #name = "${local.owners}-${local.environment}"
  eks-cluster-name = "${local.name}-${var.cluster-name}"
} 
