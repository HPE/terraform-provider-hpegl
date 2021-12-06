# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

data "hpegl_vmaas_network_interface" "e1000" {
  name     = "E1000"
  cloud_id = data.hpegl_vmaas_cloud.cloud.id
}
