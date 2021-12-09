# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

# Tier0 router
resource "hpegl_vmaas_router" "tf_tier0" {
  name     = "tf_tier0"
  enable   = true
  group_id = "shared"
  tier0_config {
    fail_over = "NON_PREEMPTIVE"
    ha_mode   = "ACTIVE_ACTIVE"
    route_redistribution_tier0 {
      tier0_static = true
    }
    route_redistribution_tier1 {
      tier1_dns_forwarder_ip = true
    }
    bgp {
      ecmp             = true
      local_as_num     = 65000
      multipath_relax  = true
      inter_sr_ibgp    = true
      restart_mode     = "HELPER_ONLY"
      restart_time     = 180
      stale_route_time = 180
    }
  }
  tier1_config {
    route_advertisement {
      tier1_lb_vip = true
    }
  }

}

# Tier1 router
resource "hpegl_vmaas_router" "tf_tier1" {
  name     = "tf_tier1"
  enable   = true
  group_id = "shared"
  tier1_config {

  }
}
