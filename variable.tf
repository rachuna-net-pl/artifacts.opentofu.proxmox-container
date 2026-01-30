variable "hostname" {
  description = "The hostname of the container"
  type        = string
}

variable "description" {
  description = "The description of the container"
  type        = string
  default     = null
}

variable "node_name" {
  description = "The name of the node to create the container on"
  type        = string
}

variable "ct_id" {
  description = "The ID of the VM"
  type        = number
}

variable "pool_id" {
  description = "The name of the pool to create the container in"
  type        = string
  default     = null
}

variable "protection" {
  description = "Whether the container is protected from accidental deletion"
  type        = bool
  default     = false
}

variable "start_on_boot" {
  description = "The startup behavior of the container"
  type        = bool
  default     = false
}

variable "tags" {
  description = "The tags to assign to the container"
  type        = list(string)
  default     = []
}

variable "unprivileged" {
  description = "Whether the container runs as unprivileged on the host"
  type        = bool
  default     = true

  # nano /etc/pve/lxc/xxx.conf 
  # lxc.apparmor.profile: unconfined
  # lxc.cgroup2.devices.allow: a
  # lxc.cap.drop:

}

variable "cpu_cores" {
  description = "The number of CPU cores to allocate to the container"
  type        = number
  default     = 1
}

variable "memory" {
  description = "The memory configuration for the container"
  type = object({
    dedicated = number
    swap      = number
  })
  default = {
    dedicated = 512
    swap      = 512
  }
}

variable "disk" {
  description = "The disk configuration for the container"
  type = object({
    storage_name = string
    disk_size    = number
  })
}

variable "is_dmz" {
  description = "Whether the container is in a DMZ (Demilitarized Zone)"
  type        = bool
  default     = false
}

variable "operating_system" {
  description = "The operating system to install on the container"
  type = object({
    template_file = string
    type          = string
  })

  validation {
    condition = contains([
      "alpine",
      "archlinux",
      "centos",
      "debian",
      "devuan",
      "fedora",
      "gentoo",
      "nixos",
      "opensuse",
      "ubuntu",
      "unmanaged",
    ], var.operating_system.type)
    error_message = "operating_system.type must be one of: alpine, archlinux, centos, debian, devuan, fedora, gentoo, nixos, opensuse, ubuntu, unmanaged."
  }

}

variable "mac_address" {
  description = "The MAC address of the container's network interface"
  type        = string
  default     = null
}

variable "features" {
  description = "LXC feature flags"
  type = object({
    keyctl  = bool
    nesting = bool
    fuse    = optional(bool)
    mount   = optional(list(string))
  })
  default = {
    keyctl  = true
    nesting = true
    fuse    = false
    mount   = []
  }
}

variable "user_account" {
  description = "Technical user created inside the container"
  type = object({
    username       = string
    password       = string
    public_ssh_key = string
  })
  sensitive = true
}
