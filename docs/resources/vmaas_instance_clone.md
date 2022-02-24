---
layout: ""
page_title: "hpegl_vmaas_instance_clone Resource - vmaas-terraform-resources-clone"
description: |-
    Instance clone resource facilitates creating,
      updating and deleting cloned virtual machines.
      For creating an instance clone, provide a unique name and all the Mandatory(Required) parameters.
      All optional parameters will be inherits from parent resource if not provided.
---

-> Compatible version >= 5.2.4

# Resource hpegl_vmaas_instance_clone

Instance clone resource facilitates creating,
	updating and deleting cloned virtual machines.
	For creating an instance clone, provide a unique name and all the Mandatory(Required) parameters.
	All optional parameters will be inherits from parent resource if not provided.


Create instance by cloning from an existing instance.

-> While cloning only source_instance_id, name and network is required. All other attributes are optional.
    if not provided, those attributes will inherits from source instance.


Cloned instance can have all the possible attributes (same as `hpegl_vmaas_instance`) apart `port`.

## Example usage for creating cloned instance with minimal attributes.

```terraform
# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

# minimal instance creation
resource "hpegl_vmaas_instance_clone" "minimal_instance" {
  name               = "tf_minimal_clone"
  source_instance_id = hpegl_vmaas_instance.tf_instance.id
  network {
    id = data.hpegl_vmaas_network.blue_net.id
  }
}
```

-> On cloning an instance parent volume will be appended with child volume. If same parent's
  volume name used in cloned instance, then the volume will be reused.


## Example usage for creating cloned instance with all available attributes.

```terraform
# (C) Copyright 2021 Hewlett Packard Enterprise Development LP


# Clone a instance from an existing instance
resource "hpegl_vmaas_instance_clone" "tf_instance_clone" {
  source_instance_id = hpegl_vmaas_instance.tf_instance.id
  name               = "tf_clone"
  cloud_id           = data.hpegl_vmaas_cloud.cloud.id
  group_id           = data.hpegl_vmaas_group.default_group.id
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
  }

  volume {
    name         = "local_vol"
    size         = 5
    datastore_id = data.hpegl_vmaas_datastore.c_3par.id
  }

  config {
    resource_pool_id = data.hpegl_vmaas_resource_pool.cl_resource_pool.id
    template_id      = data.hpegl_vmaas_template.vanilla.id
    no_agent         = true
    folder_code      = data.hpegl_vmaas_cloud_folder.compute_folder.code
    asset_tag        = "vm_tag"
  }
  hostname = "tf_host_1"
  scale    = 2
  evars = {
    proxy = "http://address:port"
  }
  power_schedule_id = data.hpegl_vmaas_powerSchedule.weekday.id
  # any update in snapshot will end up to creating new snapshot and existing
  # snapshot will be still in backend.
  snapshot {
    name        = "test_snapshot_1"
    description = "test snapshot description is optional"
  }
}
```


<!-- schema generated by tfplugindocs -->
## Schema

### Required

- **name** (String) Name of the instance to be provisioned.
- **network** (Block List, Min: 1, Max: 5) Details of the network to which the instance should belong. (see [below for nested schema](#nestedblock--network))
- **source_instance_id** (Number) Instance ID of the source instance. For getting source instance ID
		use 'hpeg_vmaas_instance' resource.

### Optional

- **cloud_id** (Number) Unique ID to identify a cloud.
- **config** (Block Set) Configuration details for the instance to be provisioned. (see [below for nested schema](#nestedblock--config))
- **env_prefix** (String) Environment prefix
- **environment_code** (String) Environment code, which can be obtained via
				hpegl_vmaas_environment.code
- **evars** (Map of String) Environment Variables to be added to the provisioned instance.
- **group_id** (Number) Unique ID to identify a group.
- **hostname** (String) Hostname for the instance
- **id** (String) The ID of this resource.
- **instance_type_code** (String) Unique code used to identify the instance type.
- **labels** (List of String) An array of strings used for labelling instance.
- **layout_id** (Number) Unique ID to identify a layout.
- **plan_id** (Number) Unique ID to identify a plan.
- **power** (String) Power operation for an instance. Power attribute can be
				use to update power state of an existing instance. Allowed power operations are
				'poweroff', 'poweron' and 'suspend'. Upon creating an instance only 'poweron' operation is allowed.
- **power_schedule_id** (Number) Scheduled power operations
- **restart_instance** (Number) Restarts the instance if set to any positive integer.
				Restart works only on pre-created instance.
- **scale** (Number) Number of nodes within an instance.
- **snapshot** (Block Set, Max: 1) Snapshot details to be created. Snapshot name and description
				 should be unique. Any change in those will results into creation of new snapshot,
				 with preserving previous snapshot(s). (see [below for nested schema](#nestedblock--snapshot))
- **tags** (Map of String) A list of key and value pairs used to tag instances of similar type.
- **volume** (Block List) A list of volumes to be created inside a provisioned instance.
				It can have a root volume and other secondary volumes. (see [below for nested schema](#nestedblock--volume))

### Read-Only

- **containers** (List of Object) Containers details for the instance which contains ip addresses, hostname and other stats (see [below for nested schema](#nestedatt--containers))
- **history** (List of Object) History details for the instance (see [below for nested schema](#nestedatt--history))
- **server_id** (Number) Unique ID to identify a server.
- **status** (String) Status of the instance.

<a id="nestedblock--network"></a>
### Nested Schema for `network`

Required:

- **id** (Number) Unique ID to identify a network ID.

Optional:

- **interface_id** (Number) Unique ID to identify a network interface type.
- **name** (String) name of the interface

Read-Only:

- **internal_id** (Number) Unique ID to identify a network intternal ID.
- **is_primary** (Boolean) Flag to identify given network is primary or not. Primary network cannot be deleted.


<a id="nestedblock--config"></a>
### Nested Schema for `config`

Required:

- **folder_code** (String) Folder in which all VMs to be spawned, use hpegl_vmaas_folder.code datasource

Optional:

- **asset_tag** (String) Asset tag
- **create_user** (Boolean) Create user
- **no_agent** (Boolean) If true agent will not be installed on the instance.
- **resource_pool_id** (Number) Unique ID to identify a resource pool.
- **template_id** (Number) Unique ID for the template


<a id="nestedblock--snapshot"></a>
### Nested Schema for `snapshot`

Required:

- **name** (String) Name of the snapshot.

Optional:

- **description** (String) Description of the snapshot
- **id** (Number) ID of the snapshot.
- **is_snapshot_exists** (Boolean) Flag which will be set to be true if the snapshot with the name
							exists.


<a id="nestedblock--volume"></a>
### Nested Schema for `volume`

Required:

- **datastore_id** (String) Datastore ID can be obtained from hpegl_vmaas_datastore
							data source. Please provide 'auto' as value to select datastore as auto.
- **name** (String) Unique name for the volume.
- **size** (Number) Size of the volume in GB.

Optional:

- **root** (Boolean) true if volume is root

Read-Only:

- **id** (Number) ID for the volume


<a id="nestedatt--containers"></a>
### Nested Schema for `containers`

Read-Only:

- **container_type** (Set of Object) (see [below for nested schema](#nestedobjatt--containers--container_type))
- **external_fqdn** (String)
- **hostname** (String)
- **id** (Number)
- **ip** (String)
- **max_cores** (Number)
- **max_memory** (Number)
- **max_storage** (Number)
- **name** (String)
- **server** (Set of Object) (see [below for nested schema](#nestedobjatt--containers--server))

<a id="nestedobjatt--containers--container_type"></a>
### Nested Schema for `containers.container_type`

Read-Only:

- **name** (String)


<a id="nestedobjatt--containers--server"></a>
### Nested Schema for `containers.server`

Read-Only:

- **compute_server_type** (Set of Object) (see [below for nested schema](#nestedobjatt--containers--server--compute_server_type))
- **date_created** (String)
- **id** (Number)
- **last_updated** (String)
- **owner** (Set of Object) (see [below for nested schema](#nestedobjatt--containers--server--owner))
- **platform** (String)
- **platform_version** (String)
- **server_os** (Set of Object) (see [below for nested schema](#nestedobjatt--containers--server--server_os))
- **ssh_host** (String)
- **ssh_port** (Number)
- **visibility** (String)

<a id="nestedobjatt--containers--server--compute_server_type"></a>
### Nested Schema for `containers.server.compute_server_type`

Read-Only:

- **external_delete** (Boolean)
- **managed** (Boolean)
- **name** (String)


<a id="nestedobjatt--containers--server--owner"></a>
### Nested Schema for `containers.server.owner`

Read-Only:

- **username** (String)


<a id="nestedobjatt--containers--server--server_os"></a>
### Nested Schema for `containers.server.server_os`

Read-Only:

- **name** (String)




<a id="nestedatt--history"></a>
### Nested Schema for `history`

Read-Only:

- **account_id** (Number)
- **created_by** (Set of Object) (see [below for nested schema](#nestedobjatt--history--created_by))
- **date_created** (String)
- **display_name** (String)
- **duration** (Number)
- **end_date** (String)
- **id** (Number)
- **instance_id** (Number)
- **last_updated** (String)
- **percent** (Number)
- **process_type** (Set of Object) (see [below for nested schema](#nestedobjatt--history--process_type))
- **reason** (String)
- **start_date** (String)
- **status** (String)
- **status_eta** (Number)
- **unique_id** (String)
- **updated_by** (Set of Object) (see [below for nested schema](#nestedobjatt--history--updated_by))

<a id="nestedobjatt--history--created_by"></a>
### Nested Schema for `history.created_by`

Read-Only:

- **display_name** (String)
- **username** (String)


<a id="nestedobjatt--history--process_type"></a>
### Nested Schema for `history.process_type`

Read-Only:

- **code** (String)
- **name** (String)


<a id="nestedobjatt--history--updated_by"></a>
### Nested Schema for `history.updated_by`

Read-Only:

- **display_name** (String)
- **username** (String)