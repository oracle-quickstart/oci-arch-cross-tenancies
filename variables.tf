# Copyright (c) 2020, Oracle and/or its affiliates. 
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Data from terraform.tfvars file

# Tenancy A
variable "tenancy_ocid_a" {}
variable "compartment_ocid_a" {}
variable "compartment_name_a" {}
variable "user_ocid_a" {}
variable "fingerprint_a" {}
variable "private_key_path_a" {}
variable "region_01_a" {}
variable "region_02_a" {}
variable "home_region_a"{}

# Tenancy B
variable "tenancy_ocid_b" {}
variable "compartment_ocid_b" {}
variable "compartment_name_b" {}
variable "user_ocid_b" {}
variable "fingerprint_b" {}
variable "private_key_path_b" {}
variable "region_01_b" {}
variable "home_region_b" {}

# SSH Keys

variable "ssh_public_key" {}

# Pick your Availability Domain
variable "AD" {
  default = "1"
}

# VCN Tenancy A - Region 01
variable "vcn_cidr_01_a" {
  default = "192.168.0.0/16"
}

variable "vcn_dns_label_01_a" {
  description = "VCN DNS label"
  default     = "vcn01a"
}

variable "dns_label_01_a" {
  description = "Subnet DNS Label"
  default     = "subnet01a"
}

variable "instance_name_01_a" {
  default = "instance_01_a"
}

# VCN Tenancy A - Region 02
variable "vcn_cidr_02_a" {
  default = "172.16.0.0/16"
}

variable "vcn_dns_label_02_a" {
  description = "VCN DNS label"
  default     = "vcn02a"
}

variable "dns_label_02_a" {
  description = "Subnet DNS Label"
  default     = "subnet02a"
}

variable "instance_name_02_a" {
  default = "instance_02_a"
}

# VCN Tenancy B - Region 01
variable "vcn_cidr_01_b" {
  default = "10.0.0.0/16"
}

variable "vcn_dns_label_01_b" {
  description = "VCN DNS label"
  default     = "vcn01b"
}

variable "dns_label_01_b" {
  description = "Subnet DNS Label"
  default     = "subnet01b"
}

variable "instance_name_01_b" {
  default = "instance_01_b"
}

# OS Images
variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "7.8"
}

### Compute Shape and Number of Instances
variable "instance_count" {
  description = "Number of instances"
  default     = "1"
}

variable "instance_shape" {
  description = "Instance Shape"
  default     = "VM.Standard2.1"
}

