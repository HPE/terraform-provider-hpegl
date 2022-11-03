# (C) Copyright 2022 Hewlett Packard Enterprise Development LP


resource "hpegl_vmaas_load_balancer_pool" "tf_POOL" {
  lb_id              = data.hpegl_vmaas_load_balancer.tf_lb.id
  name               = "tf_POOL"
  description        = "POOL created using tf"
  min_active_members = 1
  algorithm          = "WEIGHTED_ROUND_ROBIN"
  config {
    snat_translation_type   = "LBSnatAutoMap"
    active_monitor_paths    = data.hpegl_vmaas_load_balancer_monitor.tf_lb_active.id
    passive_monitor_path    = data.hpegl_vmaas_load_balancer_monitor.tf_lb_passive.id
    tcp_multiplexing        = false
    tcp_multiplexing_number = 6
    member_group {
      group              = data.hpegl_vmaas_lb_pool_member_group.tf_pool_group.external_id
      max_ip_list_size   = 1
      ip_revision_filter = "IPV4"
      port               = 80
    }
  }
  tags {
    tag   = "tag1"
    scope = "scope1"
  }
}


