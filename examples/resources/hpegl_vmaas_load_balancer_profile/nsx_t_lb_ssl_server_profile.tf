# (C) Copyright 2022 Hewlett Packard Enterprise Development LP

# SSL Profile for SERVER service
resource "hpegl_vmaas_load_balancer_profile" "tf_SSL-SERVER" {
  lb_id        = data.hpegl_vmaas_load_balancer.tf_lb.id
  name         = "tf_SSL-SERVER"
  description  = "SSL-SERVER creating using tf"
  profile_type = "ssl-profile"
  server_profile {
    service_type  = "LBServerSslProfile"
    ssl_suite     = "BALANCED"
    session_cache = true
  }
  config {
    tags {
      tag   = "tag1"
      scope = "scope1"
    }
  }
}