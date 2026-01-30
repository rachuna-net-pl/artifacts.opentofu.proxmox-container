resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "random_password" "vm" {
  length           = 16
  override_special = "_%@"
  special          = true
}

resource "proxmox_virtual_environment_container" "container" {
  description   = var.description
  tags          = var.tags
  node_name     = var.node_name
  vm_id         = var.ct_id
  protection    = var.protection
  start_on_boot = var.start_on_boot
  unprivileged  = var.unprivileged

  memory {
    dedicated = var.memory.dedicated
    swap      = var.memory.swap
  }

  cpu {
    cores = var.cpu_cores
  }

  disk {
    datastore_id = var.disk.storage_name
    size         = var.disk.disk_size
  }

  network_interface {
    bridge      = "vmbr0"
    name        = "eth0"
    vlan_id     = var.is_dmz == true ? 20 : 10
    firewall    = true
    mac_address = var.mac_address == null ? null : var.mac_address
  }

  operating_system {
    template_file_id = var.operating_system.template_file
    type             = var.operating_system.type
  }

  initialization {
    hostname = var.hostname
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      keys = [tls_private_key.ssh.public_key_openssh]
    }
  }

  features {
    keyctl  = var.features.keyctl
    nesting = var.features.nesting
    fuse    = coalesce(var.features.fuse, false)
    mount   = coalesce(var.features.mount, [])
  }

}

resource "proxmox_virtual_environment_pool_membership" "vm_membership" {
  count   = var.pool_id == null ? 0 : 1
  pool_id = var.pool_id
  vm_id   = var.ct_id
}

resource "null_resource" "post_create" {
  depends_on = [
    proxmox_virtual_environment_container.container
  ]

  triggers = {
    container_id = proxmox_virtual_environment_container.container.id
  }

  connection {
    type        = "ssh"
    host        = proxmox_virtual_environment_container.container.ipv4["eth0"]
    user        = "root"
    private_key = tls_private_key.ssh.private_key_pem
    timeout     = "120s"
    agent       = false
  }

  provisioner "remote-exec" {
    inline = [
      "set -e",
      "sudo sed -i '/^%sudo/ s#.*#%sudo ALL=(ALL:ALL) NOPASSWD: ALL#; t; $ a %sudo ALL=(ALL:ALL) NOPASSWD: ALL' /etc/sudoers",


      "echo '=== IP ADDRESS ==='",
      "ip a",

      "echo '=== USER ACCOUNT ==='",
      "id ${var.user_account.username} >/dev/null 2>&1 || useradd -m -s /bin/bash ${var.user_account.username}",
      "echo '${var.user_account.username}:${var.user_account.password}' | chpasswd",

      "usermod -aG sudo ${var.user_account.username}",

      "mkdir -p /home/${var.user_account.username}/.ssh",
      "echo '${var.user_account.public_ssh_key}' > /home/${var.user_account.username}/.ssh/authorized_keys",
      "chown -R ${var.user_account.username}:${var.user_account.username} /home/${var.user_account.username}/.ssh",
      "chmod 700 /home/${var.user_account.username}/.ssh",
      "chmod 600 /home/${var.user_account.username}/.ssh/authorized_keys"
    ]
  }
}
