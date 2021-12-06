# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

data "hpegl_vmaas_layout" "vmware_centos" {
  name               = "VMware VM with vanilla CentOS"
  instance_type_code = "glhc-vanilla-centos"
}
