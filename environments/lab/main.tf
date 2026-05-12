module "network" {
  source = "../../modules/network"

  compartment_id = var.tenancy_ocid
  vcn_cidr       = var.vcn_cidr
  subnet_cidr    = var.subnet_cidr
}

module "compute" {
  source = "../../modules/compute"

  compartment_id = var.tenancy_ocid
  subnet_id      = module.network.subnet_id
  ssh_public_key = var.ssh_public_key
}