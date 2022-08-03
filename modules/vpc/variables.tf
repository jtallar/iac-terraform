# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "cidr_block" {
  description = "The CIDR block to use for this VPC"
  type        = string

  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/(1[6-9]|2[0-8]))$", var.cidr_block))
    error_message = "The cidr_block must be a CIDR with mask between 16 and 28 (eg: 172.30.0.0/16)."
  }
}

variable "subnet_newbits" {
  description = <<-EOT
  Number of additional bits with which to extend the cidr_block prefix.
  Eg: if given a prefix ending in /16 and subnet_newbits = 4, the subnet addresses will have length /20.
  EOT
  type        = number
}

variable "name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnet_count" {
  description = "Number of subnets to create"
  type        = number
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

