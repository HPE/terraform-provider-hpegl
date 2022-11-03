# (C) Copyright 2022 Hewlett Packard Enterprise Development LP

# PASSIVE Monitor
resource "hpegl_vmaas_load_balancer_monitor" "tf_PASSIVE_MONITOR" {
  lb_id       = data.hpegl_vmaas_load_balancer.tf_lb.id
  name        = "tf_PASSIVE_MONITOR"
  description = "PASSIVE_MONITOR create using tf"
  type        = "LBPassiveMonitorProfile"
  passive_monitor {
    timeout  = 15
    max_fail = 5
  }
}