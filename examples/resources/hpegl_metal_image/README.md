# Example of creating OS service image
**IMPORTANT NOTE**: Images can be created only with an IAM token and a Metal Owner role associated with the token

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

  # hpegl_metal_image.terra_image will be created
  + resource "hpegl_metal_image" "image" {
      + id                    = (known after apply)
      + os_service_image_file = "/home/ubuntu/service.yml"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

hpegl_metal_image.terra_image: Creating...
hpegl_metal_image.terra_image: Creation complete after 2s [id=3de686c3-654b-4613-92b5-407f77b2dd13]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

```

### Argument Reference

The resource block takes the following arguments.

- `os_service_image_file` - Path to the YAML file containig the OS service image definition.

### Attribute Reference

There are no additional attributes.
