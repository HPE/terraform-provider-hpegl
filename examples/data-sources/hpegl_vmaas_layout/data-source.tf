# (C) Copyright 2021-2024 Hewlett Packard Enterprise Development LP

data "hpegl_vmaas_layout" "vmware" {
  name               = "Vmware VM"
  instance_type_code = "vmware"
}
