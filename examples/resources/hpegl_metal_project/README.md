# Example of creating project
**IMPORTANT NOTE**: Projects can be created only with an IAM token and a Metal Owner role associated with the token

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

 # hpegl_metal_project.project will be created
  + resource "hpegl_metal_project" "project" {
      + id      = (known after apply)
      + limits  {
          + "hosts"            = "5"
          + "volume_capacity"  = "300"
          + "volumes"          = "10"
          + "private_networks" = "20"
          + "instance_types"   = { "944e7b2c-a181-4aa2-afcc-35480b07caa4": 1}
        }
      + name    = "blob"
      + profile {
          + "address"             = "Area51 Nevada"
          + "company"             = "ACME"
          + "email"               = "acme@intergalactic.universe"
          + "phone_number"        = "+112 234 1245 3245"
          + "project_description" = "Primitive Life Investigations"
          + "project_name"        = "Umbrella Corporation"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

metalproject.project: Creating...


Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

```

### Argument Reference

The available_resources block takes the following arguments.

- `name` - The name of the project.
- `profile` - Details of the priject and owner.
  - `address` - (Optional) Team postal address.
  - `phone_number` - (Optional) Contact telephone number.
  - `company` - (Optional) Company name.
  - `email` - (Optional)  email address.
  - `project_description` - (Optional) Descriptive text for the project.
- `limits` - Project quotas.
  - `hosts` - Maximum number of hosts
  - `volumes` - Maximum number of volumes
  - `volume_capacity` - Maximum aggregated volume capacity in TiB
  - `private_networks` - Maximum number of private networks
  - `instance_types` - (Optional) Map of instance type ID to maximum number of hosts that can be created with that instance type

### Attribute Reference

There are not additinoal attributes.
