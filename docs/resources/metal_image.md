---
page_title: "hpegl_metal_image Resource - terraform-provider-hpegl"
subcategory: "metal"
description: |-
  Provides service image resource. This allows creation, deletion and update of Metal OS service images.
---
# hpegl_metal_image (Resource)

Provides service image resource. This allows creation, deletion and update of Metal OS service images.

## Example Usage

```terraform
// (C) Copyright 2023 Hewlett Packard Enterprise Development LP

resource "hpegl_metal_image" "image" {
  os_service_image_file = "./service.yml"
}
```

<!-- schema generated by tfplugindocs -->
## Schema

### Required

- `os_service_image_file` (String) Path to the YAML file containing the service image definition.

### Read-Only

- `id` (String) The ID of this resource.

