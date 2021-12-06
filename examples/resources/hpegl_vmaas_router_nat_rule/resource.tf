# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

resource "hpegl_vmaas_router_nat_rule" "tf_nat" {
  name        = "tf_nat_rule"
  router_id   = data.hpegl_vmaas_router.tf_router.id
  enabled     = true
  description = "NAT rule created via terraform"
  config {
    action   = "DNAT"
    logging  = true
    firewall = "MATCH_EXTERNAL_ADDRESS"
  }
  source_network      = "1.1.3.0/24"
  translated_network  = "1.1.1.0/24"
  destination_network = "1.1.2.0/24"
  translated_ports    = 22
  priority            = 120
}
