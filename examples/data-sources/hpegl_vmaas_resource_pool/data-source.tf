# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

data "hpegl_vmaas_resource_pool" "cluster" {
  cloud_id = data.hpegl_vmaas_cloud.cloud.id
  name     = "Cluster"
}
