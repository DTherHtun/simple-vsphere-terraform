data "vsphere_datacenter" "dc" {
    name = "${var.datacenter_name}"
}

data "vsphere_compute_cluster" "cluster" {
    name = "${var.cluster_name}"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "datastore" {
    name = "${var.datastore_vsan}"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
    name = "${var.port_group}"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
    name = "${var.template_centos_general}"
    datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_folder" "ocp-test" {
  path          = "${var.vm_folder_name}"
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "ocp-vm" {
    count               = "${var.number_of_host}"
    name                = "${var.vm_name}_0${count.index + 1}"
    num_cpus            = "${var.vm_cpus}"
    memory              = "${var.vm_mems}"
    folder              = "${vsphere_folder.ocp-test.path}"
    datastore_id        = "${data.vsphere_datastore.datastore.id}"
    resource_pool_id    = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
    datastore_id        = "${data.vsphere_datastore.datastore.id}"
    guest_id            = "${data.vsphere_virtual_machine.template.guest_id}"
    network_interface {
        network_id      = "${data.vsphere_network.network.id}"
        adapter_type    = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
    }
    disk {
        label            = "${var.vm_name}.vmdk"
        thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
        size             = "${var.vm_disk}"
    }
    clone {
        template_uuid   = "${data.vsphere_virtual_machine.template.id}"

        customize {
            linux_options {
                host_name   = "${var.vm_name}-0${count.index + 1}"
                domain      = "${var.vm_domain}"
            }
            network_interface {
                ipv4_address    = "${var.ip_addr}${30 + count.index}"
                ipv4_netmask    = "${var.ip_netmask}"
            }
            ipv4_gateway    = "${var.ip_gw}"
            dns_server_list = [ "${var.ip_dns}" ]
        }
    }
}
