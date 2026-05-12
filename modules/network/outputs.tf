output "subnet_id" {
  description = "O ID da Subnet Pública criada"
  value       = oci_core_subnet.k8s_public_subnet.id
}