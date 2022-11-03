# (C) Copyright 2022 Hewlett Packard Enterprise Development LP


# PERSISTENCE Profile for COOKIE service
resource "hpegl_vmaas_load_balancer_profile" "tf_PERSISTENCE-COOKIE" {
  lb_id        = data.hpegl_vmaas_load_balancer.tf_lb.id
  name         = "tf_PERSISTENCE-COOKIE"
  description  = "PERSISTENCE-COOKIE creating using tf"
  profile_type = "persistence-profile"
  cookie_profile {
    service_type      = "LBCookiePersistenceProfile"
    cookie_name       = "cookie1"
    cookie_fallback   = true
    cookie_garbling   = true
    cookie_mode       = "INSERT"
    cookie_type       = "LBPersistenceCookieTime"
    cookie_domain     = "domain1"
    cookie_path       = "http://cookie.com"
    max_idle_time     = 60
    share_persistence = true
  }
  config {
    tags {
      tag   = "tag1"
      scope = "scope1"
    }
  }
}