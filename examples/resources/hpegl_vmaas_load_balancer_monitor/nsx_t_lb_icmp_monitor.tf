# (C) Copyright 2022 Hewlett Packard Enterprise Development LP

# ICMP Monitor
resource "hpegl_vmaas_load_balancer_monitor" "tf_ICMP_MONITOR" {
  lb_id       = data.hpegl_vmaas_load_balancer.tf_lb.id
  name        = "tf_ICMP_MONITOR"
  description = "ICMP_MONITOR update using tf"
  type        = "LBIcmpMonitorProfile"
  icmp_monitor {
    fall_count   = 30
    interval     = 50
    monitor_port = 8
    rise_count   = 3
    timeout      = 15
    data_length  = 32
  }
}