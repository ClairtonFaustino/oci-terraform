resource "oci_core_vcn" "k8s_vcn" {
  compartment_id = var.compartment_id
  cidr_block     = var.vcn_cidr
  display_name   = "k8s-lab-vcn"
  dns_label      = "k8slab"
}

resource "oci_core_internet_gateway" "k8s_igw" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.k8s_vcn.id
  display_name   = "k8s-lab-igw"
  enabled        = true
}

resource "oci_core_route_table" "k8s_route_table" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.k8s_vcn.id
  display_name   = "k8s-lab-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.k8s_igw.id
  }
}

resource "oci_core_security_list" "k8s_security_list" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.k8s_vcn.id
  display_name   = "k8s-lab-sl"

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  ingress_security_rules {
    source   = var.vcn_cidr
    protocol = "all"
  }

  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "6"
    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "6"
    tcp_options {
      min = 6443
      max = 6443
    }
  }
}

resource "oci_core_subnet" "k8s_public_subnet" {
  compartment_id    = var.compartment_id
  vcn_id            = oci_core_vcn.k8s_vcn.id
  cidr_block        = var.subnet_cidr
  display_name      = "k8s-public-subnet"
  route_table_id    = oci_core_route_table.k8s_route_table.id
  security_list_ids = [oci_core_security_list.k8s_security_list.id]
  dns_label         = "k8spublic"
}