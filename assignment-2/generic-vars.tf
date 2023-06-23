# Input Variables
# AWS Region
variable "aws-region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "ap-south-1"  
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}
# Business Division
variable "business-divsion" {
  description = " this Infrastructure belongs"
  type = string
  default = "GSK"
}
