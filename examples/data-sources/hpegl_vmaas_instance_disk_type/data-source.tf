# (C) Copyright 2024 Hewlett Packard Enterprise Development LP

data "hpegl_vmaas_instance_disk_type" "vmaas_cloud_vmware_thin_lazy" {
  name      = "thick (lazy zero)"
  cloud_id  = data.hpegl_vmaas_cloud.cloud.id
  layout_id = data.hpegl_vmaas_layout.vmware.id
}