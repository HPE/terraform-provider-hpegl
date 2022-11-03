# (C) Copyright 2022 Hewlett Packard Enterprise Development LP

# HTTP Monitor
resource "hpegl_vmaas_load_balancer_monitor" "tf_HTTP_MONITOR" {
  lb_id       = data.hpegl_vmaas_load_balancer.tf_lb.id
  name        = "tf_HTTP_MONITOR"
  description = "HTTP_MONITOR creating using tf"
  type        = "LBHttpMonitorProfile"
  http_monitor {
    fall_count            = 8
    interval              = 10
    monitor_port          = 50
    rise_count            = 5
    timeout               = 30
    request_body          = "request input body data"
    request_method        = "GET"
    request_url           = "https://request.com"
    request_version       = "HTTP_VERSION_1_0"
    response_data         = "Failed"
    response_status_codes = "500"
  }
}