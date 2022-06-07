# (C) Copyright 2020-2022 Hewlett Packard Enterprise Development LP
# Example of creating a host

This is an example of creating a host that has ssh-key injection and three IP addresses on three VPNs assigned to it.

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
ips = {
  "tf-0" = {
    "Private" = "10.30.30.3"
    "Public" = "192.168.50.151"
    "Storage" = "10.20.0.216"
  }
}
```

### Argument Reference

The following arguments are supported:

- `name` - The name of the host, this will become the hostname if the operating system is a Linux flavor.
- `description` - (Optional) Some descriptive text that helps describe the host and purpose.
- `image` - A specific flavor and version in the form of flavor@version, e.g., "ubuntu@18.0.3".
- `location` - Where the host is to be created in country:region:data-center style.
- `ssh` - A list of ssh key names or IDs that will be placed into the host image.
- `size` - The machine size to use for this host.
- `networks` - A list of network names or IDs on which this host will be connected and be allocated an IP address.
- `network_route` - Network selected for the default route.
- `allocated_ips` - A list of pre-allocated IP addresses in one-to-one correspondance wth Networks.
- `volumes` - Code blocks describing any iSCSI volumes to be created and attached to the host.
  - `name` - The name of the volume.
  - `description` - (Optional) Some descriptive text that helps describe the volume and purpose.
  - `size` - The size of the volume (GiB).
  - `flavor` - The flavor of volume to create.
- `volume_attachments` - A list of existing volumeIDs or volume-names to attach to the host.
- `user_data` - Cloud init yaml information for host injection.

### Attribute Reference

In addition to the arguments listed above, the following attributes are exported:

- `ssh_ids` - List of SSH key IDs.
- `location_id` - Unique ID of the location.
- `network_ids` - List of networks IDs.
- `network_route_id` - ID of the network selected for the default route.
- `connections` - A map of {"network": "ipaddress"} for each connected network.
- `chap_user` - The iSCSI CHAP user name of the host.
- `chap_secret` - The iSCSI CHAP secret of the host.
- `initiator_name` - The iSCSI initator name of the host.
- `state` - The provisioning state of the host.
