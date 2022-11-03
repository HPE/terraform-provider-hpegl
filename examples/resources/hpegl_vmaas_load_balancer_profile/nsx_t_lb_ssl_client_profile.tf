# (C) Copyright 2022 Hewlett Packard Enterprise Development LP

# SSL Profile for CLIENT service
resource "hpegl_vmaas_load_balancer_profile" "tf_SSL-CLIENT" {
  lb_id        = data.hpegl_vmaas_load_balancer.tf_lb.id
  name         = "tf_SSL-CLIENT"
  description  = "SSL-CLIENT creating using tf"
  profile_type = "ssl-profile"
  client_profile {
    service_type                = "LBClientSslProfile"
    ssl_suite                   = "BALANCED"
    session_cache               = true
    session_cache_entry_timeout = 300
    prefer_server_cipher        = true
  }
  config {
    tags {
      tag   = "tag1"
      scope = "scope1"
    }
  }
}