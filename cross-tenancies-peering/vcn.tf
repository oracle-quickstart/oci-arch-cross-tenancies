# Networtk Tenancy A - Region 01

resource "oci_core_virtual_network" "vcn_01_a" {
  compartment_id = var.compartment_ocid_a
  cidr_block     = var.vcn_cidr_01_a
  dns_label      = var.vcn_dns_label_01_a
  display_name   = var.vcn_dns_label_01_a
}

# Internet Gateway
resource "oci_core_internet_gateway" "igw_01_a" {
  compartment_id = var.compartment_ocid_a
  display_name   = "${var.vcn_dns_label_01_a}igw"
  vcn_id         = oci_core_virtual_network.vcn_01_a.id
}

# Dynamic Routing Gateway
resource "oci_core_drg" "drg_01_a" {
  compartment_id = var.compartment_ocid_a
}

resource "oci_core_drg_attachment" "requestor_drg_attachment" {
  drg_id = oci_core_drg.drg_01_a.id
  vcn_id = oci_core_virtual_network.vcn_01_a.id
}

resource "oci_core_remote_peering_connection" "requestor_drg" {
  compartment_id   = var.compartment_ocid_a
  drg_id           = oci_core_drg.drg_01_a.id
  display_name     = "remotePeeringConnectionRequestor"
  peer_id          = oci_core_remote_peering_connection.acceptor_drg.id
  peer_region_name = var.region_02_a
}

# Public Route Table
resource "oci_core_route_table" "PublicRT_01_a" {
  compartment_id = var.compartment_ocid_a
  vcn_id         = oci_core_virtual_network.vcn_01_a.id
  display_name   = "${var.vcn_dns_label_01_a}pubrt"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.igw_01_a.id
  }

  route_rules {
    destination       = var.vcn_cidr_02_a
    network_entity_id = oci_core_drg.drg_01_a.id
  }
  route_rules {
    destination       = var.vcn_cidr_01_b
    network_entity_id = oci_core_drg.drg_01_a.id
  }
}

locals {
  tcp_protocol  = "6"
  all_protocols = "all"
  anywhere      = "0.0.0.0/0"
  ssh_port      = "22"
  icmp_protocol = "1"
}

resource "oci_core_security_list" "sec_list_01_a" {
  compartment_id = var.compartment_ocid_a
  display_name   = "Sec_List"
  vcn_id         = oci_core_virtual_network.vcn_01_a.id

  egress_security_rules {
    protocol    = local.all_protocols
    destination = local.anywhere
  }

  ingress_security_rules {
    tcp_options {
      min = local.ssh_port
      max = local.ssh_port
    }
    protocol = local.tcp_protocol
    source   = local.anywhere
  }
  ingress_security_rules {
    protocol = local.icmp_protocol
    source   = var.vcn_cidr_02_a
  }
  ingress_security_rules {
    protocol = local.icmp_protocol
    source   = var.vcn_cidr_01_b
  }
}

resource "oci_core_subnet" "subnet_01_a" {
  availability_domain = ""
  compartment_id      = var.compartment_ocid_a
  vcn_id              = oci_core_virtual_network.vcn_01_a.id
  cidr_block          = cidrsubnet(var.vcn_cidr_01_a, 8, 1)
  display_name        = var.dns_label_01_a
  dns_label           = var.dns_label_01_a
  route_table_id      = oci_core_route_table.PublicRT_01_a.id
  security_list_ids   = [oci_core_security_list.sec_list_01_a.id]
}

# Network Tenancy A - Region 02

resource "oci_core_virtual_network" "vcn_02_a" {
  provider       = oci.tenancy_a
  compartment_id = var.compartment_ocid_a
  cidr_block     = var.vcn_cidr_02_a
  dns_label      = var.vcn_dns_label_02_a
  display_name   = var.vcn_dns_label_02_a
}

# Internet Gateway
resource "oci_core_internet_gateway" "igw_02_a" {
  provider       = oci.tenancy_a
  compartment_id = var.compartment_ocid_a
  display_name   = "${var.vcn_dns_label_02_a}igw"
  vcn_id         = oci_core_virtual_network.vcn_02_a.id
}

# Dynamic Routing Gateway
resource "oci_core_drg" "drg_02_a" {
  provider       = oci.tenancy_a
  compartment_id = var.compartment_ocid_a
}

resource "oci_core_drg_attachment" "acceptor_drg_attachment" {
  provider       = oci.tenancy_a
  drg_id         = oci_core_drg.drg_02_a.id
  vcn_id         = oci_core_virtual_network.vcn_02_a.id
  route_table_id = oci_core_route_table.Transit_to_LPG.id
}

resource "oci_core_remote_peering_connection" "acceptor_drg" {
  provider       = oci.tenancy_a
  compartment_id = var.compartment_ocid_a
  drg_id         = oci_core_drg.drg_02_a.id
  display_name   = "remotePeeringConnectionAcceptor"
}

# Public Route Table
resource "oci_core_route_table" "PublicRT_02_a" {
  provider       = oci.tenancy_a
  compartment_id = var.compartment_ocid_a
  vcn_id         = oci_core_virtual_network.vcn_02_a.id
  display_name   = "${var.vcn_dns_label_02_a}pubrt"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.igw_02_a.id
  }
  route_rules {
    destination       = var.vcn_cidr_01_b
    network_entity_id = oci_core_local_peering_gateway.requestor.id
  }
  route_rules {
    destination       = var.vcn_cidr_01_a
    network_entity_id = oci_core_drg.drg_02_a.id
  }
}

# Transit Route Table
resource "oci_core_route_table" "Transit_to_DRG" {
  provider       = oci.tenancy_a
  compartment_id = var.compartment_ocid_a
  vcn_id         = oci_core_virtual_network.vcn_02_a.id
  display_name   = "transit-to-drg"

  route_rules {
    destination       = var.vcn_cidr_01_a
    network_entity_id = oci_core_drg.drg_02_a.id
  }
}

# Transit Route Table
resource "oci_core_route_table" "Transit_to_LPG" {
  provider       = oci.tenancy_a
  compartment_id = var.compartment_ocid_a
  vcn_id         = oci_core_virtual_network.vcn_02_a.id
  display_name   = "transit-to-lpg"

  route_rules {
    destination       = var.vcn_cidr_01_b
    network_entity_id = oci_core_local_peering_gateway.requestor.id
  }
}

# Local Peering Gateway

resource "oci_core_local_peering_gateway" "requestor" {
  provider       = oci.tenancy_a
  depends_on     = [oci_identity_policy.requestor_policy]
  compartment_id = var.compartment_ocid_a
  vcn_id         = oci_core_virtual_network.vcn_02_a.id
  display_name   = "requestor"
  peer_id        = oci_core_local_peering_gateway.acceptor.id
  route_table_id = oci_core_route_table.Transit_to_DRG.id
}

resource "oci_core_security_list" "sec_list_02_a" {
  provider       = oci.tenancy_a
  compartment_id = var.compartment_ocid_a
  display_name   = "Sec_List"
  vcn_id         = oci_core_virtual_network.vcn_02_a.id

  egress_security_rules {
    protocol    = local.all_protocols
    destination = local.anywhere
  }

  ingress_security_rules {
    tcp_options {
      min = local.ssh_port
      max = local.ssh_port
    }
    protocol = local.tcp_protocol
    source   = local.anywhere
  }
  ingress_security_rules {
    protocol = local.icmp_protocol
    source   = var.vcn_cidr_01_a
  }
  ingress_security_rules {
    protocol = local.icmp_protocol
    source   = var.vcn_cidr_01_b
  }
}

resource "oci_core_subnet" "subnet_02_a" {
  provider            = oci.tenancy_a
  availability_domain = ""
  compartment_id      = var.compartment_ocid_a
  vcn_id              = oci_core_virtual_network.vcn_02_a.id
  cidr_block          = cidrsubnet(var.vcn_cidr_02_a, 8, 1)
  display_name        = var.dns_label_02_a
  dns_label           = var.dns_label_02_a
  route_table_id      = oci_core_route_table.PublicRT_02_a.id
  security_list_ids   = [oci_core_security_list.sec_list_02_a.id]
}

# Network Tenancy B - Region 01

resource "oci_core_virtual_network" "vcn_01_b" {
  provider       = oci.tenancy_b
  compartment_id = var.compartment_ocid_b
  cidr_block     = var.vcn_cidr_01_b
  dns_label      = var.vcn_dns_label_01_b
  display_name   = var.vcn_dns_label_01_b
}

# Internet Gateway
resource "oci_core_internet_gateway" "igw_01_b" {
  provider       = oci.tenancy_b
  compartment_id = var.compartment_ocid_b
  display_name   = "${var.vcn_dns_label_01_b}igw"
  vcn_id         = oci_core_virtual_network.vcn_01_b.id
}

# Public Route Table
resource "oci_core_route_table" "PublicRT_01_b" {
  provider       = oci.tenancy_b
  compartment_id = var.compartment_ocid_b
  vcn_id         = oci_core_virtual_network.vcn_01_b.id
  display_name   = "${var.vcn_dns_label_01_b}pubrt"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.igw_01_b.id
  }
  route_rules {
    destination       = var.vcn_cidr_02_a
    network_entity_id = oci_core_local_peering_gateway.acceptor.id
  }
  route_rules {
    destination       = var.vcn_cidr_01_a
    network_entity_id = oci_core_local_peering_gateway.acceptor.id
  }
}

# Local Peering Gateway

resource "oci_core_local_peering_gateway" "acceptor" {
  provider       = oci.tenancy_b
  depends_on     = [oci_identity_policy.acceptor_policy]
  compartment_id = var.compartment_ocid_b
  vcn_id         = oci_core_virtual_network.vcn_01_b.id
  display_name   = "acceptor"
}

resource "oci_core_security_list" "sec_list_01_b" {
  provider       = oci.tenancy_b
  compartment_id = var.compartment_ocid_b
  display_name   = "Sec_List"
  vcn_id         = oci_core_virtual_network.vcn_01_b.id

  egress_security_rules {
    protocol    = local.all_protocols
    destination = local.anywhere
  }

  ingress_security_rules {
    tcp_options {
      min = local.ssh_port
      max = local.ssh_port
    }
    protocol = local.tcp_protocol
    source   = local.anywhere
  }
  ingress_security_rules {
    protocol = local.icmp_protocol
    source   = var.vcn_cidr_01_a
  }
  ingress_security_rules {
    protocol = local.icmp_protocol
    source   = var.vcn_cidr_02_a
  }
}

resource "oci_core_subnet" "subnet_01_b" {
  provider            = oci.tenancy_b
  availability_domain = ""
  compartment_id      = var.compartment_ocid_b
  vcn_id              = oci_core_virtual_network.vcn_01_b.id
  cidr_block          = cidrsubnet(var.vcn_cidr_01_b, 8, 1)
  display_name        = var.dns_label_01_b
  dns_label           = var.dns_label_01_b
  route_table_id      = oci_core_route_table.PublicRT_01_b.id
  security_list_ids   = [oci_core_security_list.sec_list_01_b.id]
}