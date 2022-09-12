# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

# Tier0 router
resource "hpegl_vmaas_router" "tf_tier0" {
  name     = "tf_tier0_gateway"
  enable   = true
  group_id = "shared"
  tier0_config {
    bgp {
      ecmp             = true
      enable_bgp       = true
      inter_sr_ibgp    = false
      local_as_num     = 65000
      multipath_relax  = true
      restart_mode     = "HELPER_ONLY"
      restart_time     = 180
      stale_route_time = 600
    }
    route_redistribution_tier0 {
      tier0_dns_forwarder_ip   = false
      tier0_external_interface = true
      tier0_ipsec_local_ip     = false
      tier0_loopback_interface = true
      tier0_nat                = true
      tier0_segment            = true
      tier0_service_interface  = true
      tier0_static             = true
    }
    route_redistribution_tier1 {
      tier1_dns_forwarder_ip     = false
      tier1_service_interface    = true
      tier1_ipsec_local_endpoint = false
      tier1_lb_snat              = false
      tier1_lb_vip               = false
      tier1_nat                  = false
      tier1_segment              = true
      tier1_static               = false
    }
    fail_over    = "NON_PREEMPTIVE"
    ha_mode      = "ACTIVE_STANDBY"
    edge_cluster = data.hpegl_vmaas_edge_cluster.tf_edge_cluster.provider_id
  }
}