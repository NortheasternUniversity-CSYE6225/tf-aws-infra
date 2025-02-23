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

variable "app_port" {
  type        = number
  description = "Custom Application port"
}

variable "ssh_port" {
  type        = number
  description = "Custom SSH port"
}

variable "http_port" {
  type        = number
  description = "Custom HTTP port"
}

variable "https_port" {
  type        = number
  description = "Custom HTTPS port"
}

variable "ssh_port_cidr" {
  type        = list(string)
  description = "CIDR blocks for SSH access"
}

variable "http_port_cidr" {
  type        = list(string)
  description = "CIDR blocks for HTTP access"
}

variable "https_port_cidr" {
  type        = list(string)
  description = "CIDR blocks for HTTPS access"
}

variable "app_port_cidr" {
  type        = list(string)
  description = "CIDR blocks for Application port access"
}

variable "custom_ami_id" {
  type        = string
  description = "Custom AMI ID"
}

variable "ec2_instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "volume_size" {
  type        = number
  description = "Volume size"
}

variable "volume_type" {
  type        = string
  description = "Volume type"
}

variable "delete_on_termination" {
  type        = bool
  description = "Delete on termination"
}

variable "disable_api_termination" {
  type        = bool
  description = "Disable API termination"
}

variable "protocol" {
  type        = string
  description = "Protocol"
}