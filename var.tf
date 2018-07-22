variable "profile" {
  description = "profile name to get valid credentials of account"
}

variable "aws_region" {
  default = "ap-south-1"
}

variable "vpc_id" {
 description = "The VPC ID to create in"
}

variable "public_subnets" {
  description = "List of all external subnets"
  type        = "map"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = "list"
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "name" {
  description = "Name tag, e.g stack"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}
