resource "oci_identity_policy" "requestor_policy" {
  provider       = oci.home_region_a
  name           = "Local_Peering_Policy"
  description    = "Local_Peering_Policy"
  compartment_id = var.tenancy_ocid_a
  statements = ["Define tenancy Acceptor as ${var.tenancy_ocid_b}",
    "Endorse group Administrators to manage local-peering-to in tenancy Acceptor",
    "Endorse group Administrators to associate local-peering-gateways in compartment ${var.compartment_name_a} with local-peering-gateways in tenancy Acceptor",
    "Allow group Administrators to manage local-peering-from in compartment ${var.compartment_name_a}"
  ]
}

resource "oci_identity_policy" "acceptor_policy" {
  provider       = oci.home_region_b
  name           = "Local_Peering_Policy"
  description    = "Local_Peering_Policy"
  compartment_id = var.tenancy_ocid_b
  statements = ["Define tenancy Requestor as ${var.tenancy_ocid_a}",
    "Define group RequestorGrp as ocid1.group.oc1..aaaaaaaachg2jo6vblnpg7ccujaez6as7tvpviefw33yhygijjkanwpb6fea",
    "Allow group Administrators to manage local-peering-from in compartment ${var.compartment_name_b}",
    "Admit group RequestorGrp of tenancy Requestor to manage local-peering-to in compartment ${var.compartment_name_b}",
    "Admit group RequestorGrp of tenancy Requestor to associate local-peering-gateways in tenancy Requestor with local-peering-gateways in compartment ${var.compartment_name_b}"
  ]

}