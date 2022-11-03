# (C) Copyright 2022 Hewlett Packard Enterprise Development LP

resource "hpegl_vmaas_load_balancer" "tf_lb" {
  name        = "tf_loadbalancer"
  description = "Loadbalancer created using tf"
  enabled     = true
  group_access {
    all = true
  }
  config {
    admin_state    = true
    size           = "SMALL"
    log_level      = "INFO"
    tier1_gateways = data.hpegl_vmaas_router.tier1_router.provider_id
  }
}

