# <img src="docs/proxmox.png" alt="proxmox" height="20"/> proxmox-container

Moduł opentofu do zarządzanie kontenerami LXC (CT) w środowisku Proxmox VE.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2.4 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | ~> 0.87.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.7.2 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | ~> 3.2.4 |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | ~> 0.87.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.7.2 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.post_create](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [proxmox_virtual_environment_container.container](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_container) | resource |
| [proxmox_virtual_environment_pool_membership.vm_membership](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_pool_membership) | resource |
| [random_password.vm](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [tls_private_key.ssh](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cpu_cores"></a> [cpu\_cores](#input\_cpu\_cores) | The number of CPU cores to allocate to the container | `number` | `1` | no |
| <a name="input_ct_id"></a> [ct\_id](#input\_ct\_id) | The ID of the VM | `number` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The description of the container | `string` | `null` | no |
| <a name="input_disk"></a> [disk](#input\_disk) | The disk configuration for the container | <pre>object({<br/>    storage_name = string<br/>    disk_size    = number<br/>  })</pre> | n/a | yes |
| <a name="input_features"></a> [features](#input\_features) | LXC feature flags | <pre>object({<br/>    keyctl  = bool<br/>    nesting = bool<br/>    fuse    = optional(bool)<br/>    mount   = optional(list(string))<br/>  })</pre> | <pre>{<br/>  "fuse": false,<br/>  "keyctl": true,<br/>  "mount": [],<br/>  "nesting": true<br/>}</pre> | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | The hostname of the container | `string` | n/a | yes |
| <a name="input_is_dmz"></a> [is\_dmz](#input\_is\_dmz) | Whether the container is in a DMZ (Demilitarized Zone) | `bool` | `false` | no |
| <a name="input_mac_address"></a> [mac\_address](#input\_mac\_address) | The MAC address of the container's network interface | `string` | `null` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The memory configuration for the container | <pre>object({<br/>    dedicated = number<br/>    swap      = number<br/>  })</pre> | <pre>{<br/>  "dedicated": 512,<br/>  "swap": 512<br/>}</pre> | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | The name of the node to create the container on | `string` | n/a | yes |
| <a name="input_operating_system"></a> [operating\_system](#input\_operating\_system) | The operating system to install on the container | <pre>object({<br/>    template_file = string<br/>    type          = string<br/>  })</pre> | n/a | yes |
| <a name="input_pool_id"></a> [pool\_id](#input\_pool\_id) | The name of the pool to create the container in | `string` | `null` | no |
| <a name="input_protection"></a> [protection](#input\_protection) | Whether the container is protected from accidental deletion | `bool` | `false` | no |
| <a name="input_start_on_boot"></a> [start\_on\_boot](#input\_start\_on\_boot) | The startup behavior of the container | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to assign to the container | `list(string)` | `[]` | no |
| <a name="input_unprivileged"></a> [unprivileged](#input\_unprivileged) | Whether the container runs as unprivileged on the host | `bool` | `true` | no |
| <a name="input_user_account"></a> [user\_account](#input\_user\_account) | Technical user created inside the container | <pre>object({<br/>    username       = string<br/>    password       = string<br/>    public_ssh_key = string<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_ipv4"></a> [container\_ipv4](#output\_container\_ipv4) | Primary IPv4 address of the container (eth0) |
| <a name="output_root_password"></a> [root\_password](#output\_root\_password) | Generated root password for the container |
| <a name="output_root_private_key"></a> [root\_private\_key](#output\_root\_private\_key) | Generated root private key (PEM) |
| <a name="output_root_public_key"></a> [root\_public\_key](#output\_root\_public\_key) | Generated root public SSH key |
<!-- END_TF_DOCS -->

---
## Contributions
Jeśli masz pomysły na ulepszenia, zgłoś problemy, rozwidl repozytorium lub utwórz Merge Request. Wszystkie wkłady są mile widziane!
[Contributions](CONTRIBUTING.md)

---
## License
Projekt licencjonowany jest na warunkach [Licencji MIT](LICENSE).

---
# Author Information
### &emsp; Maciej Rachuna
# <img src="docs/logo.png" alt="rachuna-net.pl" height="100"/>
