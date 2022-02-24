---
layout: ""
page_title: "hpegl_vmaas_router_nat_rule Resource - vmaas-terraform-resources"
description: |-
    Router NAT rule resource facilitates creating,
          updating and deleting NSX-T Network Router NAT rules.
---

-> Compatible version >= 5.2.10

# Resource hpegl_vmaas_router_nat_rule

Router NAT rule resource facilitates creating,
		updating and deleting NSX-T Network Router NAT rules.
`hpegl_vmaas_router_nat_rule` resource supports NSX-T network router NAT rule creation.

For creating an NSX-T network router NAT rule, please refer following examples.

## Example usage for creating NSX-T Network router NAT rule with all possible attributes

```terraform
# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

resource "hpegl_vmaas_router_nat_rule" "tf_nat" {
  name        = "tf_nat_rule"
  router_id   = data.hpegl_vmaas_router.tf_router.id
  enabled     = true
  description = "NAT rule created via terraform"
  config {
    action   = "DNAT"
    logging  = true
    firewall = "MATCH_EXTERNAL_ADDRESS"
  }
  source_network      = "1.1.3.0/24"
  translated_network  = "1.1.1.0/24"
  destination_network = "1.1.2.0/24"
  translated_ports    = 22
  priority            = 120
}
```

-> `destination_network` should be set when `action` is set to `DNAT`. Similarly `source_network`
should be set when `action` is set to `SNAT`.

<!-- schema generated by tfplugindocs -->
## Schema

### Required

- **config** (Block List, Min: 1, Max: 1) NAT configurations (see [below for nested schema](#nestedblock--config))
- **name** (String) Name of the NAT rule.
- **router_id** (Number) Parent router ID, router_id can be obtained by using router datasource/resource.
- **translated_network** (String) Translated Network CIDR/IPv4 Address

### Optional

- **description** (String) Description for the NAT rule.
- **destination_network** (String) Destination Network CIDR/IPv4 Address
- **enabled** (Boolean) If `true` then NAT rule will be active/enabled.
- **id** (String) The ID of this resource.
- **priority** (Number) Priority for the rule
- **source_network** (String) Source Network CIDR/IPv4 Address
- **translated_ports** (Number) Translated Network Port

<a id="nestedblock--config"></a>
### Nested Schema for `config`

Required:

- **action** (String) NAT Rule Type. Supported values are `DNAT` and `SNAT`

Optional:

- **firewall** (String) Firewall Type. Supported values are : MATCH_EXTERNAL_ADDRESS,
							MATCH_INTERNAL_ADDRESS, BYPASS
- **logging** (Boolean) Enable/Disable Logging
- **service** (String) Type of the service