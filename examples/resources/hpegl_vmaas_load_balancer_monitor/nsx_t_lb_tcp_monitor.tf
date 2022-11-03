# (C) Copyright 2022 Hewlett Packard Enterprise Development LP

# TCP Monitor
resource "hpegl_vmaas_load_balancer_monitor" "tf_TCP_MONITOR" {
  lb_id       = data.hpegl_vmaas_load_balancer.tf_lb.id
  name        = "tf_TCP_MONITOR"
  description = "TCP_MONITOR create using tf"
  type        = "LBTcpMonitorProfile"
  tcp_monitor {
    fall_count    = 3
    interval      = 5
    monitor_port  = 80
    rise_count    = 3
    timeout       = 15
    request_body  = "request body data"
    response_data = "success"
  }
}