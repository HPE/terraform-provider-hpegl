# (C) Copyright 2022 Hewlett Packard Enterprise Development LP

# HTTPS Monitor
resource "hpegl_vmaas_load_balancer_monitor" "tf_HTTPS_MONITOR" {
  lb_id       = data.hpegl_vmaas_load_balancer.tf_lb.id
  name        = "tf_HTTPS_MONITOR"
  description = "HTTPS_MONITOR creating using tf"
  type        = "LBHttpsMonitorProfile"
  https_monitor {
    fall_count            = 3
    interval              = 5
    monitor_port          = 80
    rise_count            = 3
    timeout               = 15
    request_body          = "request input body data"
    request_method        = "GET"
    request_url           = "https://test.com"
    request_version       = "HTTP_VERSION_1_1"
    response_data         = "success"
    response_status_codes = "201,200"
  }
}