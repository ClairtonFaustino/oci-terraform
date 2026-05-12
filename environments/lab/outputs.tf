output "master_ip" {
  value = module.compute.master_public_ip
}

output "workers_ips" {
  value = module.compute.workers_public_ips
}