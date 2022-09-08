# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

# Tier1 router
resource "hpegl_vmaas_router" "tf_tier1" {
  name     = "tf_tier1"
  enable   = true
  group_id = "shared"
  tier1_config {
    tier0_gateway = data.hpegl_vmaas_router.tier0_router.provider_id
    edge_cluster  = data.hpegl_vmaas_edge_cluster.tf_edge_cluster.provider_id
    fail_over     = "NON_PREEMPTIVE"
    route_advertisement {
      tier1_connected            = true
      tier1_static_routes        = false
      tier1_dns_forwarder_ip     = true
      tier1_lb_vip               = false
      tier1_nat                  = false
      tier1_lb_snat              = false
      tier1_ipsec_local_endpoint = true
    }
  }
}