# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

resource "hpegl_vmaas_network" "test_net" {
  name         = "tf_net_custom"
  description  = "Network created using tf"
  display_name = "tf_net_nsx_t"
  group_id     = data.hpegl_vmaas_group.tf_group.id
  scope_id     = "/infra/sites/default/enforcement-points/default/transport-zones/88cd4dc8-0445-4b8e-b260-0f4cd361f4e1"
  dhcp_server  = false
  cidr         = "168.72.10.0/18"
  gateway      = "168.72.10.9"
  primary_dns  = "8.8.8.8"
  scan_network = false
  active       = true
  config {
    connected_gateway = data.hpegl_vmaas_router.tf_router.provider_id
  }
  resource_permission {
    all = true
  }
}
