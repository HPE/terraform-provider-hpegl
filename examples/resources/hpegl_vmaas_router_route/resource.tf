# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

resource "hpegl_vmaas_router_route" "tf_route" {
  name          = "tf_route"
  router_id     = 71
  description   = "my description"
  enabled       = true
  default_route = false
  network       = "30.0.0.0/24"
  next_hop      = "88.88.88.91"
  mtu           = "65535"
  priority      = 100
}
