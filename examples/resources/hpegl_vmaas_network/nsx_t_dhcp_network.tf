# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

resource "hpegl_vmaas_network" "dhcp_net" {
  name                       = "tf_nsx_t_dhcp_network"
  description                = "DHCP Network create using tf"
  display_name               = "tf_nsx_t_dhcp_network"
  scope_id                   = data.hpegl_vmaas_transport_zone.tf_zone.provider_id
  cidr                       = "10.100.0.1/24"
  primary_dns                = "8.8.8.8"
  scan_network               = false
  active                     = true
  allow_static_override      = true
  appliance_url_proxy_bypass = true
  group_id                   = "shared"
  dhcp_enabled               = true
  connected_gateway          = data.hpegl_vmaas_router.tier1_router.provider_id
  resource_permissions {
    all = true
  }
  dhcp_network {
    dhcp_type           = "dhcpLocal"
    dhcp_server         = data.hpegl_vmaas_dhcp_server.tf_dhcp.provider_id
    dhcp_lease_time     = "86400"
    dhcp_range          = "10.100.0.11-10.100.0.250"
    dhcp_server_address = "10.100.0.2/24"
  }
}