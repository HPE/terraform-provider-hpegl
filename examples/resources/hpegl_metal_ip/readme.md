# Example of creating an IP

This is an example of creating (allocating) an IP from an IP pool.

To run the example:
* Authenticate against a portal using steeld login
* Update `variables.tf` OR provide overrides on the command line
* Run with a command similar to
```
terraform apply \
    -var ="location=USA:Texas:AUSL2"
    -var ="ip_pool_id={Id of the IP pool to perform the allocation}"
    -var ="ip={IP to be allocated}"
``` 

## Example output

```
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # hpegl_metal_ip.ip1 will be created
  + resource "hpegl_metal_ip" "ip1" {
      + id         = (known after apply)
      + ip         = "10.0.0.16"
      + ip_pool_id = "390194d3-5163-474b-af62-9c5fa7825408"
      + usage      = "Usage for ip1"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + ip1 = {
      + id         = (known after apply)
      + ip         = "10.0.0.16"
      + ip_pool_id = "390194d3-5163-474b-af62-9c5fa7825408"
      + usage      = "Usage for ip1"
    }

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

hpegl_metal_ip.ip1: Creating...
hpegl_metal_ip.ip1: Creation complete after 0s [id=390194d3-5163-474b-af62-9c5fa7825408:10.0.0.16]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

ip1 = {
  "id" = "390194d3-5163-474b-af62-9c5fa7825408:10.0.0.16"
  "ip" = "10.0.0.16"
  "ip_pool_id" = "390194d3-5163-474b-af62-9c5fa7825408"
  "usage" = "Usage for ip1"
}
```

### Argument Reference

The following arguments are supported:

- `ip` - The IP address to be allocated.
- `ip_pool_id` - ID of the IP pool from which the IP will be allocated.
- `usage` - Description of the IP allocation.
