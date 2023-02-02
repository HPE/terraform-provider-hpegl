---
layout: ""
page_title: "hpegl_vmaas_load_balancer_pool Resource - vmaas-terraform-resources"
subcategory: "vmaas"
description: |-
    loadbalancer Pool resource facilitates creating, updating
          and deleting NSX-T Network Load Balancer Pools.
---

# Resource hpegl_vmaas_load_balancer_pool

-> Compatible version >= 5.4.6

loadbalancer Pool resource facilitates creating, updating
		and deleting NSX-T Network Load Balancer Pools.
`hpegl_vmaas_load_balancer_pool` resource supports NSX-T Load Balancer Pool creation.

## Example usage for creating NSX-T Load Balancer Pool with all possible attributes

```terraform
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
```

<!-- schema generated by tfplugindocs -->
## Schema

### Required

- `algorithm` (String) Load balancing pool algorithm controls how the incoming connectionsare distributed among the members
- `lb_id` (Number) Parent lb ID, lb_id can be obtained by using LB datasource/resource.
- `name` (String) Network loadbalancer pool name

### Optional

- `config` (Block List) pool Configuration (see [below for nested schema](#nestedblock--config))
- `description` (String) Creating the Network loadbalancer pool.
- `min_active_members` (Number) The minimum number of members for the pool to be considered active
- `tags` (Block List) tags Configuration (see [below for nested schema](#nestedblock--tags))

### Read-Only

- `id` (String) The ID of this resource.

<a id="nestedblock--config"></a>
### Nested Schema for `config`

Optional:

- `active_monitor_paths` (Number) Active Monitor ID, Get the `id` from hpegl_vmaas_load_balancer_monitor datasource to obtain the active monitor ID
- `member_group` (Block List) member group (see [below for nested schema](#nestedblock--config--member_group))
- `passive_monitor_path` (Number) Passive Monitor ID, Get the `id` from hpegl_vmaas_load_balancer_monitor datasource to obtain the passive monitor ID
- `snat_ip_address` (String) Address of the snat_ip for Network loadbalancer pool
- `snat_translation_type` (String) Network Loadbalancer Supported values are `LBSnatAutoMap`,`LBSnatDisabled`, `LBSnatIpPool`
- `tcp_multiplexing` (Boolean) With TCP multiplexing, user can use the same TCP connectionbetween a load balancer and the server forsending multiple client requests from different client TCP connections.
- `tcp_multiplexing_number` (Number) The maximum number of TCP connections per poolthat are idly kept alive for sending future client requests

<a id="nestedblock--config--member_group"></a>
### Nested Schema for `config.member_group`

Optional:

- `group` (String) Pool Member Groups path, get the `externalId` from hpegl_vmaas_lb_pool_member_groupdatasource to obtain the path
- `ip_revision_filter` (String) Ip version filter is used to filter `IPv4` addresses from the grouping object
- `max_ip_list_size` (Number) It Should only be specified if `limit_ip_list_size` is set to true.Limits the max number of pool members to the specified value
- `port` (Number) This is member port, The traffic which enter into VIP will get transferto member groups based on the port specified.Depends on the application running on the member VM



<a id="nestedblock--tags"></a>
### Nested Schema for `tags`

Optional:

- `scope` (String) scope for Network Load balancer Pool
- `tag` (String) tag for Network Load balancer Pool