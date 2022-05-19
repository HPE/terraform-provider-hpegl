# Example of finding specifc images

This is an example of geting specifc image information.

To run the example:
* Authenticate against a portal using steeld login
* Run with a command similar to
```
terraform apply 
``` 

## Example output

```
images = [
  {
    "category" = "linux"
    "flavor" = "ubuntu"
    "id" = "8cd33cd7-7ea9-4125-8aaf-5f495328131e"
    "version" = "18.04-20190807"
  },
]

```

### Argument Reference

The following arguments are supported:

- `filter` - This describes a filter operation to locate only certain images. Multiple filters can be applied using mutiple blocks. Filters are evaluated using a logical AND.
  - `name` - The name of the field to fiter on eg "flavor" or "category" or "version"
  - `values` - A list of possible regexps that can match


### Attribute Reference

In addition to the arguments listed above, the following attributes are exported:

- `images` - List of matching images.
   - `category` - The OS categoty, e.g. "linux".
   - `flavor` - The OS flavor, e.g. "ubuntu".
   - `version` - The available OS versions
   