# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

resource "hpegl_vmaas_router_firewall_rule_group" "tf_router_firewall_rule_group" {
  name        = "tf_router_firewall_group"
  router_id   = data.hpegl_vmaas_router.tf_router.id
  description = "Router Firewall rule group created via terraform"
  priority    = 120
  group_layer = "LocalGatewayRules"
}
