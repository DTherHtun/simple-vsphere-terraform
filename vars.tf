variable "VSPHERE_USER" {}
variable "VSPHERE_PASSWORD" {}
variable "VSPHERE_SERVER" {}
variable "ALLOW_UNVERIFIED_SSL" {}

variable "datacenter_name" {}
variable "cluster_name" {}
variable "datastore_vsan" {}
variable "port_group" {}

variable "vm_folder_name" {}
variable "resource_pool_default" {}
variable "template_centos_general" {}
variable "number_of_host" {}

variable "ip_dns" { type = list(string) }
variable "ip_addr" {}
variable "ip_netmask" {}
variable "ip_gw" {}

variable "vm_name" {}
variable "vm_cpus" {}
variable "vm_mems" {}
variable "vm_disk" {}
variable "vm_domain" {}