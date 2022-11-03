#(C) Copyright 2022 Hewlett Packard Enterprise Development LP

data "hpegl_vmaas_load_balancer_pool" "tf_pool" {
  lb_id = data.hpegl_vmaas_load_balancer.tf_lb.id
  name  = "tf_POOL"
}
