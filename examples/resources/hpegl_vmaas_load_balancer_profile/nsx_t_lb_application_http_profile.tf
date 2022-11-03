# (C) Copyright 2022 Hewlett Packard Enterprise Development LP


# APPLICATION Profile for HTTP service
resource "hpegl_vmaas_load_balancer_profile" "tf_APPLICATION-HTTP" {
  lb_id        = data.hpegl_vmaas_load_balancer.tf_lb.id
  name         = "tf_APPLICATION-HTTP"
  description  = "APPLICATION-HTTP-Profile creating using tf"
  profile_type = "application-profile"
  http_profile {
    service_type         = "LBHttpProfile"
    http_idle_timeout    = 30
    request_header_size  = 1024
    response_header_size = 4096
    redirection          = "https"
    x_forwarded_for      = "INSERT"
    request_body_size    = 20
    response_timeout     = 60
    ntlm_authentication  = true
  }
  config {
    tags {
      tag   = "tag1"
      scope = "scope1"
    }
    tags {
      tag   = "tag2"
      scope = "scope2"
    }
  }
}