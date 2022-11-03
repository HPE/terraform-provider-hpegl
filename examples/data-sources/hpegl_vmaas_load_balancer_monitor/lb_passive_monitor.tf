#(C) Copyright 2022 Hewlett Packard Enterprise Development LP

data "hpegl_vmaas_load_balancer_monitor" "tf_lb_passive" {
  lb_id = data.hpegl_vmaas_load_balancer.tf_lb.id
  name  = "default-passive-lb-monitor"
}
