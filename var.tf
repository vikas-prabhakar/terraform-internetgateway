variable "aws_region" {
  default = "ap-south-1"
}

variable "profile" {
  description = "profile name to get valid credentials of account"
}

variable "vpc_id" {
  description = "The VPC ID to create in"
}

variable "name" {
  description = "Name tag, e.g stack"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}
