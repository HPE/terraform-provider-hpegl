---
page_title: "hpegl_metal_available_images Data Source - terraform-provider-hpegl"
subcategory: "metal"
description: |-
  Provides a list of available Image Services for a project.
---
# hpegl_metal_available_images (Data Source)
Provides a list of available Image Services for a project.
## Example Usage
```terraform
// (C) Copyright 2020-2022 Hewlett Packard Enterprise Development LP

data "hpegl_metal_available_images" "centos" {
  filter {
    name   = "flavor"
    values = ["(?i)centos"] // case insensitive for Centos or centos etc.
  }
  filter {
    name   = "version"
    values = ["7.6.*"] // al 7.6.XXXX image variants
  }
}

output "images" {
  value = data.hpegl_metal_available_images.ubuntu.images
}
```
<!-- schema generated by tfplugindocs -->
## Schema

### Optional

- `filter` (Block Set) (see [below for nested schema](#nestedblock--filter))

### Read-Only

- `id` (String) The ID of this resource.
- `images` (List of Object) (see [below for nested schema](#nestedatt--images))

<a id="nestedblock--filter"></a>
### Nested Schema for `filter`

Required:

- `name` (String)
- `values` (List of String)


<a id="nestedatt--images"></a>
### Nested Schema for `images`

Read-Only:

- `category` (String)
- `flavor` (String)
- `id` (String)
- `version` (String)
