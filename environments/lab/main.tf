module "network" {
  source = "../../modules/network"

  compartment_id = var.tenancy_ocid
  vcn_cidr       = var.vcn_cidr
  subnet_cidr    = var.subnet_cidr
}