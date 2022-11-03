#(C) Copyright 2022 Hewlett Packard Enterprise Development LP

data "hpegl_vmaas_load_balancer_profile" "tf_ssl_client_profile" {
  lb_id = data.hpegl_vmaas_load_balancer.tf_lb.id
  name  = "tf_SSL-CLIENT"
}
