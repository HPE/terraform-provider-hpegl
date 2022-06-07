# Example of creating an ssh-key for use in host creation

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

  # hpegl_metal_ssh_key.an_other will be created
  + resource "hpegl_metal_ssh_key" "an_other" {
      + id         = (known after apply)
      + name       = "an_other"
      + public_key = "ssh-rsa AAAAB3NzaC1yc2E<...Redacted...>== user1@quattronetworks.com"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

hpegl_metal_ssh_key.an_other: Creating...
hpegl_metal_ssh_key.an_other: Creation complete after 0s [id=172acf8e-677b-4bda-ac85-24f5207fe1a2]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

```

### Argument Reference

The available_resources block takes the following arguments.

- `name` - The name of the ssh key public key.
- `public_key` - The full public key.


### Attribute Reference

There are no additional attributes.