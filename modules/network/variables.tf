variable "compartment_id" {
  description = "OCID do Compartment onde a rede será criada."
  type        = string
}

variable "vcn_cidr" {
  description = "Bloco CIDR da VCN"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Bloco CIDR da Subnet Pública"
  type        = string
  default     = "10.0.1.0/24"
}