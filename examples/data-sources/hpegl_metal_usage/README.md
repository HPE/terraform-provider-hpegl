# Obtaining usage information from the physical infrastructure

This is an example of querying the physical infrastructure to obtain consumption information for compute, 
networks and storage resources.

To run the example:
* Authenticate against a portal using steeld login
* Update `variables.tf` OR provider overrides on the command line
* Run with a command similar to
```
terraform apply \
    -var ="billing_months=01-2020"
``` 

After running `terraform apply` a list of details resources will be emitted in json format.

Note: If additional resources have been created outside of Terraform these will be including in the usage.

## Example Output
```
compute_consuption = [
  {
    "allocated" = "2020-01-21T17:37:18Z"
    "cost" = "51.00"
    "freed" = ""
    "hourly_rate" = "0.75"
    "id" = "785b60f4-29d0-4715-8f9a-5e1744539ccd"
    "machine_size" = "Any"
    "machine_size_id" = "944e7b2c-a181-4aa2-afcc-35480b07caa4"
    "monthly_rate" = "275"
    "name" = "test-0"
    "team_id" = ""
    "usage_hours" = 68
  },
  {
    "allocated" = "2020-01-24T13:10:55Z"
    "cost" = "0.75"
    "freed" = ""
    "hourly_rate" = "0.75"
    "id" = "ca57f104-f2a2-4e39-99ad-d0568b235ebc"
    "machine_size" = "Any"
    "machine_size_id" = "944e7b2c-a181-4aa2-afcc-35480b07caa4"
    "monthly_rate" = "275"
    "name" = "tf-0"
    "team_id" = ""
    "usage_hours" = 1
  },
]
volume_consuption = [
  {
    "allocated" = "2020-01-21T17:37:18Z"
    "cost" = "0.01"
    "flavor" = "Fast"
    "flavor_id" = "fe2f751e-ef4c-4d60-afb4-f2c87059ed41"
    "freed" = ""
    "hourly_rate" = "0.0001"
    "id" = "472b5f03-095d-4cd1-8fc6-98cbc6de947c"
    "monthly_rate" = "0.0025"
    "name" = "large-volume-0"
    "size" = 5
    "team_id" = ""
    "usage_hours" = 68
  },
  {
    "allocated" = "2020-01-24T10:19:55Z"
    "cost" = "0.01"
    "flavor" = "Fast"
    "flavor_id" = "fe2f751e-ef4c-4d60-afb4-f2c87059ed41"
    "freed" = ""
    "hourly_rate" = "0.0001"
    "id" = "ac8571e9-9948-41d6-a6ad-d39a4c5ceec3"
    "monthly_rate" = "0.0025"
    "name" = "v1"
    "size" = 33
    "team_id" = ""
    "usage_hours" = 3
  },
]

```

### Argument Reference

The usage block takes the following arguments.

- `billing_months` - The month to compute the usage for in MM-YYY format, e.g. 01-2020. If empty the current month is assumed.

### Attribute Reference

In addition to the arguments listed above, the following attributes are exported:

- `host_usage` - List of all host usages over the billing period.
  - `name` - The name of the host that caused the billing record.
  - `size` - The size of the machine allocated.
  - `size_id` - The machines size ID.
  - `cost` - The cost of the machine in the location currency.
  - `hourly_rate` - The charge rate for the machine per hour.
  - `monthly_rate` - The monthly maximum chagable for the machine.
  - `usage_hours` - The number of hours the host was provosinoed for.
  - `team_id`- The team ID of the chargable entity, if not the caller.
  - `allocated` -The timestamp of when the host was allocated/
  - `freed` - The timestamp of when the host was released, an empty string represents a host that is still operational.
- `volume_usage` - List of all volume usage over the billing period.
  - `name` - The name of the volume that caused the billing record.
  - `flavor` - The flavor of the volume allocated.
  - `flavor_id` - The volume flavor size ID.
  - `size` - The size of the volume allocated, units are GiB.
  - `cost` - The cost of the volume in the location currency.
  - `hourly_rate` - The charge rate for the volume per hour.
  - `monthly_rate` - The monthly maximum chagable for the volume.
  - `usage_hours` - The number of hours the volume was provosinoed for.
  - `team_id`- The team ID of the chargable entity, if not the caller.
  - `allocated` -The timestamp of when the volume was allocated/
  - `freed` - The timestamp of when the volume was released, an empty string represents a host that is still operational.