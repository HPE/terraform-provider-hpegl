# (C) Copyright 2024 Hewlett Packard Enterprise Development LP

data "hpegl_vmaas_instance_storage_controller" "scsi_0" {
  layout_id        = data.hpegl_vmaas_layout.vmware.id
  controller_name  = "SCSI VMware Paravirtual"
  bus_number       = 0
  interface_number = 0
}