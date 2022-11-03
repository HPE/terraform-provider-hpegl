# (C) Copyright 2022 Hewlett Packard Enterprise Development LP


# APPLICATION Profile for TCP service
resource "hpegl_vmaas_load_balancer_profile" "tf_APPLICATION-TCP" {
  lb_id        = data.hpegl_vmaas_load_balancer.tf_lb.id
  name         = "tf_APPLICATION-TCP"
  description  = "APPLICATION-TCP creating using tf"
  profile_type = "application-profile"
  tcp_profile {
    service_type             = "LBFastTcpProfile"
    fast_tcp_idle_timeout    = 1800
    connection_close_timeout = 8
    ha_flow_mirroring        = true
  }
  config {
    tags {
      tag   = "tag1"
      scope = "scope1"
    }
  }
}