<!-- (C) Copyright 2020-2023 Hewlett Packard Enterprise Development LP -->
# Example of creating an iSCSI volume

An isolated iSCSI volume maybe attached to a host at host-creation time by simply referencing the volume name in the volumes code-block
for the host.

To run the example:
* Authenticate against a portal using steeld login
* Run with a command similar to
```
terraform apply
```

## Example output
```
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # hpegl_metal_volume.test_vols[0] will be created
  + resource "hpegl_metal_volume" "test_vols" {
      + description = "Terraformed volume"
      + flavor      = "Fast"
      + flavor_id   = (known after apply)
      + id          = (known after apply)
      + location    = "USA:Texas:AUSL2"
      + location_id = (known after apply)
      + name        = "vol-0"
      + size        = 20
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

hpegl_metal_volume.test_vols[0]: Creating...
hpegl_metal_volume.test_vols[0]: Creation complete after 3s [id=177bc7ee-c11b-4c48-84d5-348eefa72aef]

volumes = [
  {
    "description" = "Terraformed volume"
    "flavor" = "Fast"
    "flavor_id" = "fe2f751e-ef4c-4d60-afb4-f2c87059ed41"
    "storage_pool_id" = "4028a467-4960-41d8-94b5-7611e50c0642"
    "id" = "fdc3cb01-8a7d-453a-a3e5-8d6d96cdcb86"
    "location" = "USA:Texas:AUSL2"
    "location_id" = "b3b64a26-fdb2-4d4d-9f8d-5096cbb662a6"
    "volume_collection_id" = "d5a63736-a03f-4779-8a08-0b3763f86704"
    "name" = "vol-0"
    "size" = 20
  },
]
```

### Argument Reference

The following arguments are supported:

- `name` - The name of the volume.
- `description` - (Optional) Some descriptive text that helps describe the volume and purpose.
- `volume_flavor` - The flavor of the volume to be created, e.g. "Default"
- `storage_pool` - (Optional) The storage pool where to create the volume, e.g. "Storage_Pool_NVMe"
- `location` - Where the volume is to be created in country:region:data-center style.
- `size` - The volume size, units are GiB.

### Attribute Reference

In addition to the arguments listed above, the following computed attributes are returned to the user:

- `location_id` - Unique ID of the location.
- `flavor_id` - unique ID of the chosen flavor.
- `storage_pool_id` - unique ID of the storage pool.
- `state` - The provisioning state of the volume.
- `status` - The provisioning status of the volume.
- `volume_collection_id` - (optional) unique id of the volume collection