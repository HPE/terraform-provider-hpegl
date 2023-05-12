# Example of creating a network

This is an example of creating a network for use by a project.

To run the example:
* Authenticate against a portal using steeld login
* Update `variables.tf` OR provide overrides on the command line
* Run with a command similar to
```
terraform apply \
    -var ="location=USA:Texas:AUSL2"
``` 

## Example output

```
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # hpegl_metal_network.pnet will be created
  + resource "hpegl_metal_network" "pnet" {
      + description = "A desciption of pnet"
      + host_use    = (known after apply)
      + id          = (known after apply)
      + kind        = (known after apply)
      + location    = "USA:Texas:AUSL2"
      + location_id = (known after apply)
      + name        = "pnet"
      + ip_pool     = [
        + {
            + base_ip       = "10.0.0.0"
            + default_route = ""
            + description   = "A description of npool"
            + dns           = []
            + ip_ver        = "IPv4"
            + name          = "npool"
            + netmask       = "/24"
            + no_proxy      = ""
            + ntp           = []
            + proxy         = ""
            + sources       = []
          },
        ]
      + ip_pool_id  = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

hpegl_metal_network.pnet: Creating...
hpegl_metal_network.pnet: Creation complete after 0s [id=edaa63c1-3f01-47a8-933f-cbee5a30708f]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

pnet = {
  "description" = "A desciption of pnet"
  "host_use" = "Optional"
  "id" = "edaa63c1-3f01-47a8-933f-cbee5a30708f"
  "kind" = "Custom"
  "location" = "USA:Texas:AUSL2"
  "name" = "pnet"
  "ip_pool" = toset([
    {
      "base_ip" = "10.0.0.0"
      "default_route" = ""
      "description" = "A description of npool"
      "dns" = tolist([])
      "ip_ver" = "IPv4"
      "name" = "npool60"
      "netmask" = "/24"
      "no_proxy" = ""
      "ntp" = tolist([])
      "proxy" = ""
      "sources" = tolist([])
    },
  ])
  "ip_pool_id" = "0c2047ef-a24a-432a-b87d-7c454c1e3a83"
}

```

### Argument Reference

The following arguments are supported:

- `name` - The name of the network.
- `description` - (Optional) Some descriptive text that helps describe the network and purpose.
- `location` - Where the network is to be created in country:region:data-center style.
- `host_use` - (Optional) Host network use policy. Allowed values are Required, Oprional and Default.
- `purpose` - (Optional) Purpose of the network. Allowed values are Backup, Storage, vmKernel, vmNSX-T, vMotion, vCHA, vmFT, iSCSI-A, iSCSI-B, Telemetry and External
- `ip_pool` - (Optional) IP pool used by the network. If not defined an IP allocated from the hoster IP pool factory will be used.
- `vlan` - (Optional) VLAN ID of the network. If not specified, it is allocated from the reserved pool.
- `vni` - (Optional) VNI ID of the network. If not specified, it is allocated from the reserved pool if required.

### Attribute Reference

In addition to the arguments listed above, the following computed attributes are returned to the user:

- `location_id` - Unique ID of the location.
- `ip_pool_id` - Unique ID of the network IP pool.
- `vlan` - VLAN ID of the network when it is allocated from the reserved pool.
- `vni` - VNI ID of the network when it is allocated from the reserved pool if required.




