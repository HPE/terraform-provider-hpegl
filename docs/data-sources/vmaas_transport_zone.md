---
page_title: "hpegl_vmaas_transport_zone Data Source - terraform-provider-hpegl"
subcategory: "vmaas"
description: |-
  The hpegl_vmaas_transport_zone data source can be used to discover the ID of a hpegl vmaas transport zone.
  This can then be used with resources or data sources that require an hpegl_vmaas_transport_zone
---
# hpegl_vmaas_transport_zone (Data Source)

The hpegl_vmaas_transport_zone data source can be used to discover the ID of a hpegl vmaas transport zone.
		This can then be used with resources or data sources that require an hpegl_vmaas_transport_zone

## Example Usage

```terraform
# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

data "hpegl_vmaas_transport_zone" "tf_zone" {
  name = "nsx_transport_zone_overlay"
}
```

<!-- schema generated by tfplugindocs -->
## Schema

### Required

- `name` (String) Name of the transport zone as it appears on HPE GreenLake for private cloud dashboard. If there is no transport zone with this name, a 'NOT FOUND' error will returned.

### Read-Only

- `external_id` (String)
- `id` (String) The ID of this resource.
- `internal_id` (String)
- `provider_id` (String) scope_id of the transport zone. Use the scope_id as transport zone while creating network


