# Copyright (c) 2020, Oracle and/or its affiliates. 
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Compute Instances - Tenancy A - Region 01

resource "oci_core_instance" "instances_01_a" {
  availability_domain = data.oci_identity_availability_domains.ADs_A.availability_domains[var.AD - 1]["name"]
  compartment_id      = var.compartment_ocid_a
  display_name        = var.instance_name_01_a
  shape               = var.instance_shape
  subnet_id           = oci_core_subnet.subnet_01_a.id

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID_A.images[0].id
    boot_volume_size_in_gbs = "50"
  }

  metadata = {
    ssh_authorized_keys = chomp(file(var.ssh_public_key))
  }
}

# Compute Instances - Tenancy A - Region 02

resource "oci_core_instance" "instances_02_a" {
  provider            = oci.tenancy_a
  availability_domain = data.oci_identity_availability_domains.ADs_B.availability_domains[var.AD - 1]["name"]
  compartment_id      = var.compartment_ocid_a
  display_name        = var.instance_name_02_a
  shape               = var.instance_shape
  subnet_id           = oci_core_subnet.subnet_02_a.id

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID_B.images[0].id
    boot_volume_size_in_gbs = "50"
  }

  metadata = {
    ssh_authorized_keys = chomp(file(var.ssh_public_key))
  }
}

# Compute Instances - Tenancy B - Region 01

resource "oci_core_instance" "instances_01_b" {
  provider            = oci.tenancy_b
  availability_domain = data.oci_identity_availability_domains.ADs_C.availability_domains[var.AD - 1]["name"]
  compartment_id      = var.compartment_ocid_b
  display_name        = var.instance_name_01_b
  shape               = var.instance_shape
  subnet_id           = oci_core_subnet.subnet_01_b.id

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.InstanceImageOCID_C.images[0].id
    boot_volume_size_in_gbs = "50"
  }

  metadata = {
    ssh_authorized_keys = chomp(file(var.ssh_public_key))
  }
}