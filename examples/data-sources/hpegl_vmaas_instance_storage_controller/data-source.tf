# (C) Copyright 2024 Hewlett Packard Enterprise Development LP

variable "instance_id" {
  type    = number
  default = 0
}
data "hpegl_vmaas_instance_storage_controller" "scsi3" {
  instance_id      = var.instance_id
  controller_type  = "scsi"
  bus_number       = 0
  interface_number = 3
}