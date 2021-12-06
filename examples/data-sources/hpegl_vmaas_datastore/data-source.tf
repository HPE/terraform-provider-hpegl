# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

data "hpegl_vmaas_datastore" "c_3par" {
  cloud_id = data.hpegl_vmaas_cloud.cloud.id
  name     = "Compute-3par-A64G-FC-1TB"
}
