output "root_password" {
  description = "Generated root password for the container"
  value       = random_password.vm.result
  sensitive   = true
}

output "root_private_key" {
  description = "Generated root private key (PEM)"
  value       = tls_private_key.ssh.private_key_pem
  sensitive   = true
}

output "root_public_key" {
  description = "Generated root public SSH key"
  value       = tls_private_key.ssh.public_key_openssh
}

output "container_ipv4" {
  description = "Primary IPv4 address of the container (eth0)"
  value       = try(proxmox_virtual_environment_container.container.ipv4["eth0"], null)
}
