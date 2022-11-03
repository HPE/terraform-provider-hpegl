# (C) Copyright 2022 Hewlett Packard Enterprise Development LP

resource "hpegl_vmaas_load_balancer_virtual_server" "tf_lb_virtual_server" {
  lb_id       = data.hpegl_vmaas_load_balancer.tf_lb.id
  name        = "tf_virtual-server"
  description = "tf_virtual-server created by tf"
  vip_address = "10.11.12.13"
  vip_port    = "8080"
  pool        = data.hpegl_vmaas_load_balancer_pool.tf_pool.id

  type = "http"
  http_application_profile {
    application_profile = data.hpegl_vmaas_load_balancer_profile.tf_http_profile.id
  }

  persistence = "COOKIE"
  cookie_persistence_profile {
    persistence_profile = data.hpegl_vmaas_load_balancer_profile.tf_cookie_profile.id
  }

  ssl_server_cert = data.hpegl_vmaas_load_balancer_virtual_server_ssl_cert.tf_ssl_cert.id
  ssl_server_config {
    ssl_server_profile = data.hpegl_vmaas_load_balancer_profile.tf_ssl_server_profile.id
  }

  ssl_client_cert = data.hpegl_vmaas_load_balancer_virtual_server_ssl_cert.tf_ssl_cert.id
  ssl_client_config {
    ssl_client_profile = data.hpegl_vmaas_load_balancer_profile.tf_ssl_client_profile.id
  }

}


