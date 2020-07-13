# Copyright (c) 2020, Oracle and/or its affiliates. 
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Get list of Availability Domains
data "oci_identity_availability_domains" "ADs_A" {
  compartment_id = "${var.tenancy_ocid_a}"
}

data "oci_identity_availability_domains" "ADs_B" {
  provider       = oci.tenancy_a
  compartment_id = "${var.tenancy_ocid_a}"
}

data "oci_identity_availability_domains" "ADs_C" {
  provider       = oci.tenancy_b
  compartment_id = "${var.tenancy_ocid_b}"
}

# Get the latest Oracle Linux image
data "oci_core_images" "InstanceImageOCID_A" {
  compartment_id           = var.compartment_ocid_a
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

# Get the latest Oracle Linux image
data "oci_core_images" "InstanceImageOCID_B" {
  provider                 = oci.tenancy_a
  compartment_id           = var.compartment_ocid_a
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

# Get the latest Oracle Linux image
data "oci_core_images" "InstanceImageOCID_C" {
  provider                 = oci.tenancy_b
  compartment_id           = var.compartment_ocid_b
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}