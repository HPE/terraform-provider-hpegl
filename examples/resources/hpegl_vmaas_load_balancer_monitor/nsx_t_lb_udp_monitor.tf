# (C) Copyright 2022 Hewlett Packard Enterprise Development LP

# UDP Monitor
resource "hpegl_vmaas_load_balancer_monitor" "tf_UDP-MONITOR" {
  lb_id       = data.hpegl_vmaas_load_balancer.tf_lb.id
  name        = "tf_UDP-MONITOR"
  description = "UDP_MONITOR create using tf"
  type        = "LBUdpMonitorProfile"
  udp_monitor {
    fall_count    = 3
    interval      = 5
    monitor_port  = 80
    rise_count    = 3
    timeout       = 15
    request_body  = "request body data"
    response_data = "success"
  }
}
