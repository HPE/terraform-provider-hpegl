---
page_title: "hpegl_vmaas_instance_storage_controller Data Source - terraform-provider-hpegl"
subcategory: "vmaas"
description: |-
  The hpegl_vmaas_instance_storage_controller data source can be used to discover the ID of a storage controller mount.
  This can then be used with resources or data sources that require a hpegl_vmaas_instance_disk_type,
  such as the hpegl_vmaas_instance resource.
---
# hpegl_vmaas_instance_storage_controller (Data Source)

The hpegl_vmaas_instance_storage_controller data source can be used to discover the ID of a storage controller mount.
		This can then be used with resources or data sources that require a hpegl_vmaas_instance_disk_type,
		such as the hpegl_vmaas_instance resource.

## Example Usage

```terraform
# (C) Copyright 2024 Hewlett Packard Enterprise Development LP

variable "instance_id" {
  type    = number
  default = 0
}
data "hpegl_vmaas_instance_storage_controller" "scsi3" {
  instance_id      = var.instance_id
  controller_type  = "scsi"
  bus_number       = 0
  interface_number = 3
}
```

<!-- schema generated by tfplugindocs -->
## Schema

### Required

- `bus_number` (Number) The Bus sequence for a storage controller type
- `controller_type` (String) The storage controller name displayed in an instance. Supported values are `IDE`, `SCSI`
- `instance_id` (Number) Unique ID to identify an instance
- `interface_number` (Number) The interface number to be allocated

### Read-Only

- `id` (String) The ID of this resource.

