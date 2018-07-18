provider "vsphere" {
    user                    = "${var.VSPHERE_USER}"
    password                = "${var.VSPHERE_PASSWORD}"
    vsphere_server          = "${var.VSPHERE_SERVER}"
    allow_unverified_ssl    = "${var.ALLOW_UNVERIFIED_SSL}"
}