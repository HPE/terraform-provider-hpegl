# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

resource "hpegl_vmaas_router_bgp_neighbor" "tf_router_bgp_neighbor" {
  router_id             = data.hpegl_vmaas_router.tf_tier0.id
  ip_address            = "10.201.227.84"
  remote_as             = 65000
  keepalive             = 60
  holddown              = 180
  router_filtering_type = "IPV4"
  bfd_enabled           = false
  bfd_interval          = 1000
  bfd_multiple          = 3
  allow_as_in           = false
  hop_limit             = 1
  restart_mode          = "HELPER_ONLY"
  config {
    source_addresses = [data.hpegl_vmaas_router.tf_tier0.interfaces[0].source_addresses]
  }
}