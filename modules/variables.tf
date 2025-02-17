# Variables for VPC and other resources
variable "environment" {
    type        = string
    description = "Environment name (e.g., dev1, dev2, prod)"
}

variable "vpc_cidr" {
    type        = string
    description = "CIDR block for VPC"
}

variable "public_subnet_count" {
    type        = number
    description = "Number of public subnets to create"
}

variable "private_subnet_count" {
    type        = number
    description = "Number of public subnets to create"
}

variable "public_subnet_cidrs" {
    type        = list(string)
    description = "CIDR blocks for public subnets"
}

variable "private_subnet_cidrs" {
    type        = list(string)    
    description = "CIDR blocks for private subnets"
}

variable "public_route" {
    type        = string
    description = "Public route"
}

variable "az_state" {
    type        = string
    description = "State of availability zones"  
}

variable "instance_tenancy" {
    type        = string
    description = "Tenancy of the instance"
    default     = "default"
}