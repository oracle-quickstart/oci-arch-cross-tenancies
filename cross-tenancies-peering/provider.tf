provider "oci" {
  tenancy_ocid         = var.tenancy_ocid_a
  user_ocid            = var.user_ocid_a
  fingerprint          = var.fingerprint_a
  private_key_path     = var.private_key_path_a
  region               = var.region_01_a
}

provider "oci" {
  alias                = "tenancy_a"
  tenancy_ocid         = var.tenancy_ocid_a
  user_ocid            = var.user_ocid_a
  fingerprint          = var.fingerprint_a
  private_key_path     = var.private_key_path_a
  region               = var.region_02_a
}

provider "oci" {
  alias            = "tenancy_b"
  tenancy_ocid     = var.tenancy_ocid_b
  user_ocid        = var.user_ocid_b
  fingerprint      = var.fingerprint_b
  private_key_path = var.private_key_path_b
  region           = var.region_01_b
}

provider "oci" {
  alias                = "home_region_a"
  tenancy_ocid         = var.tenancy_ocid_a
  user_ocid            = var.user_ocid_a
  fingerprint          = var.fingerprint_a
  private_key_path     = var.private_key_path_a
  region               = var.home_region_a
}

provider "oci" {
  alias            = "home_region_b"
  tenancy_ocid     = var.tenancy_ocid_b
  user_ocid        = var.user_ocid_b
  fingerprint      = var.fingerprint_b
  private_key_path = var.private_key_path_b
  region           = var.home_region_b
}