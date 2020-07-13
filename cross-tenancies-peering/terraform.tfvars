# Copyright (c) 2020, Oracle and/or its affiliates. 
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Authentication to Tenancy A - Region 01 and Region 02
tenancy_ocid_a         = "ocid1.tenancy.oc1.."
user_ocid_a            = "ocid1.user.oc1.."
fingerprint_a          = "07:e9:97..."
private_key_path_a     = "/api-keys/XXXXX.pem"
region_01_a            = "ap-mumbai-1"
region_02_a            = "us-ashburn-1"
compartment_ocid_a     = "ocid1.compartment.oc1.."
compartment_name_a     = "Demo"

# Authentication to Tenancy B Region 01
tenancy_ocid_b     = "ocid1.tenancy.oc1.."
user_ocid_b        = "ocid1.user.oc1.."
fingerprint_b      = "ec:cd:73:...."
private_key_path_b = "/api-keys/XXXXX.pem"
region_01_b        = "us-ashburn-1"
compartment_ocid_b = "ocid1.compartment.oc1.."
compartment_name_b = "Demo01"

# SSH Keys
ssh_public_key  = "/ssh-keys/key.pub"

# Home Region
home_region_a = "us-phoenix-1"
home_region_b = "us-ashburn-1"