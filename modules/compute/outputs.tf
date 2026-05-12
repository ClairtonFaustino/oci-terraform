output "master_public_ip" {
  value = oci_core_instance.k8s_master.public_ip
}

output "workers_public_ips" {
  value = oci_core_instance.k8s_worker[*].public_ip
}