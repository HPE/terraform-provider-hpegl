#  (C) Copyright 2021 Hewlett Packard Enterprise Development LP

data "hpegl_vmaas_layout" "vmware" {
  name          = "VMware"
  instance_type = "Vmware VM"
}
