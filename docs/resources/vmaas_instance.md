---
layout: ""
page_title: "hpegl_vmaas_instance Resource - vmaas-terraform-resources"
description: |-
    Instance resource facilitates creating,
          updating and deleting virtual machines.
          For creating an instance, provide a unique name and all the Mandatory(Required) parameters.
          It is recommend to use the Vmware type for provisioning.
---

# Resource hpegl_vmaas_instance

Instance resource facilitates creating,
		updating and deleting virtual machines.
		For creating an instance, provide a unique name and all the Mandatory(Required) parameters.
		It is recommend to use the Vmware type for provisioning.

`hpegl_vmaas_instance` resource support instance creation as well cloning an existing
instance.

-> It is mandatory to choose the 'template_id' while creating the instance of type 'vmware'
(for this purpose `hpegl_vmaas_template` can be used). If not, an error will be returned. This mandation 
does not apply for other instance types(no error will be prompted in this case).

For creating an instance please refer following examples.

~> Volume name should be unique. No error will be prompted if the volume name is repeated, but 
unexpected behavior can be expected, during instance update.


## Example usage for creating new instance with only required attributes

```terraform
# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

# minimal instance creation
resource "hpegl_vmaas_instance" "minimal_instance" {
  name               = "tf_minimal"
  cloud_id           = data.hpegl_vmaas_cloud.cloud.id
  group_id           = data.hpegl_vmaas_group.default_group.id
  layout_id          = data.hpegl_vmaas_layout.vmware_centos.id
  plan_id            = data.hpegl_vmaas_plan.g1_small.id
  instance_type_code = data.hpegl_vmaas_layout.vmware_centos.instance_type_code
  network {
    id = data.hpegl_vmaas_network.blue_net.id
  }

  volume {
    name         = "root_vol"
    size         = 5
    datastore_id = data.hpegl_vmaas_datastore.c_3par.id
    root         = true
  }

  config {
    resource_pool_id = data.hpegl_vmaas_resource_pool.cl_resource_pool.id
  }
  environment_code = data.hpegl_vmaas_environment.dev.code
}
```

-> `power` attribute is supported upon creating an instance. But only `poweron`  operation is supported
    while creating an instance.

## Example usage for creating new instance with all possible attributes

```terraform
# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

# create instance will all possible options
resource "hpegl_vmaas_instance" "tf_instance" {
  name               = "tf_advanced"
  cloud_id           = data.hpegl_vmaas_cloud.cloud.id
  group_id           = data.hpegl_vmaas_group.default_group.id
  layout_id          = data.hpegl_vmaas_layout.vmware.id
  plan_id            = data.hpegl_vmaas_plan.g1_small.id
  instance_type_code = data.hpegl_vmaas_layout.vmware.instance_type_code
  network {
    id = data.hpegl_vmaas_network.blue_net.id
  }
  network {
    id = data.hpegl_vmaas_network.green_net.id
  }

  volume {
    name         = "root_vol"
    size         = 5
    datastore_id = data.hpegl_vmaas_datastore.c_3par.id
    root         = true
  }

  volume {
    name         = "Local_vol"
    size         = 5
    datastore_id = data.hpegl_vmaas_datastore.c_3par.id
    root         = false
  }

  labels = ["test_label"]
  tags = {
    key  = "value"
    name = "data"
    some = "fdsfs"
  }

  config {
    resource_pool_id = data.hpegl_vmaas_resource_pool.cl_resource_pool.id
    template_id      = data.hpegl_vmaas_template.vanilla.id
    no_agent         = true
    create_user      = true
    asset_tag        = "vm_tag"
  }
  hostname = "hpegl_tf_host"
  scale    = 2
  evars = {
    proxy = "http://some:proxy"
  }
  env_prefix        = "tf_test"
  power_schedule_id = data.hpegl_vmaas_power_schedule.weekday.id
  port {
    name = "nginx"
    port = 80
    lb   = "No LB"
  }
  environment_code = data.hpegl_vmaas_environment.dev.code
  # On creating only poweron operation is supported. Upon updation all other
  # lifecycle operations are permitted.
  power = "poweron"
}
```

You can also create instance by cloning from an existing instance. To do so use `clone` attribute
and provide `source_instance_id` along with it

~> While cloning an instance you need to make sure that the Primary volume and Primary Network should
  be the same as the **parent instance**. Terraform will not return any error but cloning an instance with
  updated Primary volume/Network may result parent instance goes into failed state

Cloned instance can have all the possible attributes (same as create new instance). The only difference will be
the additional `clone` attribute.

## Example usage for creating cloned instance

```terraform
# (C) Copyright 2021 Hewlett Packard Enterprise Development LP


# Clone a instance from an existing instance
resource "hpegl_vmaas_instance" "tf_instance_clone" {
  name               = "tf_clone"
  cloud_id           = data.hpegl_vmaas_cloud.cloud.id
  group_id           = data.hpegl_vmaas_group.default_group.id
  layout_id          = data.hpegl_vmaas_layout.vmware.id
  plan_id            = data.hpegl_vmaas_plan.g1_small.id
  instance_type_code = data.hpegl_vmaas_layout.vmware.instance_type_code
  network {
    id = data.hpegl_vmaas_network.blue_net.id
  }
  network {
    id = data.hpegl_vmaas_network.green_net.id
  }

  volume {
    name         = "root_vol"
    size         = 5
    datastore_id = data.hpegl_vmaas_datastore.c_3par.id
    root         = true
  }

  volume {
    name         = "Local_vol"
    size         = 5
    datastore_id = data.hpegl_vmaas_datastore.c_3par.id
    root         = false
  }

  config {
    resource_pool_id = data.hpegl_vmaas_resource_pool.cl_resource_pool.id
    template_id      = data.hpegl_vmaas_template.vanilla.id
    no_agent         = true
    create_user      = false
    asset_tag        = "vm_tag"
  }
  hostname = "hpegl_tf_host_clone"
  scale    = 2
  evars = {
    proxy = "http://some:proxy"
  }
  power_schedule_id = data.hpegl_vmaas_powerSchedule.weekday.id
  clone {
    source_instance_id = hpegl_vmaas_instance.tf_instance.id
  }
}
```


<!-- schema generated by tfplugindocs -->
## Schema

### Required

- **cloud_id** (Number) Unique ID to identify a cloud.
- **config** (Block Set, Min: 1) Configuration details for the instance to be provisioned. (see [below for nested schema](#nestedblock--config))
- **group_id** (Number) Unique ID to identify a group.
- **instance_type_code** (String) Unique code used to identify the instance type.
- **layout_id** (Number) Unique ID to identify a layout.
- **name** (String) Name of the instance to be provisioned.
- **network** (Block List, Min: 1) Details of the network to which the instance should belong. (see [below for nested schema](#nestedblock--network))
- **plan_id** (Number) Unique ID to identify a plan.
- **volume** (Block List, Min: 1) A list of volumes to be created inside a provisioned instance.
				It can have a root volume and other secondary volumes. (see [below for nested schema](#nestedblock--volume))

### Optional

- **clone** (Block Set) If Clone is provided, this instance will created from cloning an existing instance (see [below for nested schema](#nestedblock--clone))
- **env_prefix** (String) Environment prefix
- **environment_code** (String) Environment code, which can be obtained via
				hpegl_vmaas_environment.code
- **evars** (Map of String) Environment Variables to be added to the provisioned instance.
- **hostname** (String) Hostname for the instance
- **id** (String) The ID of this resource.
- **labels** (List of String) An array of strings used for labelling instance.
- **port** (Block List) Provide port (see [below for nested schema](#nestedblock--port))
- **power** (String) Power operation for an instance. Power attribute can be
				use to update power state of an existing instance. Allowed power operations are
				'poweroff','poweron','restart' and 'suspend'. Upon creating an instance only 'poweron' operation is allowed.
- **power_schedule_id** (Number) Scheduled power operations
- **scale** (Number) Number of nodes within an instance.
- **tags** (Map of String) A list of key and value pairs used to tag instances of similar type.

### Read-Only

- **status** (String) Status of the instance.

<a id="nestedblock--config"></a>
### Nested Schema for `config`

Required:

- **resource_pool_id** (Number) Unique ID to identify a resource pool.

Optional:

- **asset_tag** (String) Asset tag
- **create_user** (Boolean) If true new user will be created
- **no_agent** (Boolean) If true agent will not be installed on the instance.
- **template_id** (Number) Unique ID for the template
- **vm_folder** (String) Folder name where will be stored.


<a id="nestedblock--network"></a>
### Nested Schema for `network`

Required:

- **id** (Number) Unique ID to identify a network ID.

Optional:

- **interface_id** (Number) Unique ID to identify a network interface type.


<a id="nestedblock--volume"></a>
### Nested Schema for `volume`

Required:

- **datastore_id** (String) Unique ID to identify a datastore.
- **name** (String) Unique name for the volume.
- **size** (Number) Size of the volume in GB.

Optional:

- **root** (Boolean) If true then the given volume as considered as root volume.

Read-Only:

- **id** (Number) ID for the volume


<a id="nestedblock--clone"></a>
### Nested Schema for `clone`

Required:

- **source_instance_id** (String) Instance ID of the source.


<a id="nestedblock--port"></a>
### Nested Schema for `port`

Required:

- **lb** (String) Load balancing configuration for ports.
							 Supported values are "No LB", "HTTP", "HTTPS", "TCP"
- **name** (String) Name of the port
- **port** (String) Port value in string
