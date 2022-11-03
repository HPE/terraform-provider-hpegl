# (C) Copyright 2022 Hewlett Packard Enterprise Development LP

resource "hpegl_vmaas_dhcp_server" "tf_dhcp_server" {
  name           = "tf_dhcp_server"
  lease_time     = 86400
  server_address = "100.96.0.1/24"
  config {
    edge_cluster = data.hpegl_vmaas_edge_cluster.tf_edge_cluster.provider_id
  }
}