---
layout: ""
page_title: "hpegl_vmaas_instance Resource - vmaas-terraform-resources"
subcategory: "vmaas"
description: |-
  This Instance resource facilitates creating,
  updating and deleting virtual machines. HPE recommends that you use the VMware as type for provisioning.
---

-> Compatible version >= 5.2.4

# Resource hpegl_vmaas_instance

This Instance resource facilitates creating,
		updating and deleting virtual machines. HPE recommends that you use the VMware as type for provisioning.

`hpegl_vmaas_instance` resource supports instance creation and cloning an existing
instance.

-> It is mandatory to choose the `template_id` while creating the instance of type 'vmware'
(for this purpose `hpegl_vmaas_template` can be used). If not, an error will be returned. This mandation
does not apply for other instance types (no error will be prompted in this case).

For creating an instance, use the following examples.

~> Volume name should be unique. An error is displayed  if the volume name is repeated.

Terraform will consider first volume as the primary volume. `root` attribute (computed field) will set to
root volume.

-> Deleting the root volume is not supported.

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
  }

  config {
    resource_pool_id = data.hpegl_vmaas_resource_pool.cl_resource_pool.id
    folder_code      = data.hpegl_vmaas_cloud_folder.compute_folder.code
  }
  environment_code = data.hpegl_vmaas_environment.dev.code
}
```

-> `power` attribute is supported for `hpegl_vmaas_instance`, but only `poweron`  operation is supported
    while creating.

For creating snapshot use `snapshot` attribute. Any update in snapshot's `name` or `description`
will result in the creation of a new snapshot.

~> Reconfiguring an instance causes the snapshot to be deleted.

`is_snapshot_exist` field in `snapshot` will be true if the snapshot exists under an instance. Use
this field to identify whether snapshot got deleted (because of reconfigure or anything else).

-> Snapshot update, apply and delete is not supported yet.

## Example usage for creating new instance with all possible attributes

```terraform
# (C) Copyright 2021-2024 Hewlett Packard Enterprise Development LP

# create instance with all possible options
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
    storage_type = data.hpegl_vmaas_instance_disk_type.vmaas_cloud_vmware_thin_lazy.id
  }

  volume {
    name         = "local_vol"
    size         = 5
    datastore_id = data.hpegl_vmaas_datastore.c_3par.id
    storage_type = data.hpegl_vmaas_instance_disk_type.vmware_thin.id
    controller   = data.hpegl_vmaas_instance_storage_controller.scsi_0.id
  }
  volume {
    name         = "data_vol"
    size         = 5
    datastore_id = data.hpegl_vmaas_datastore.c_3par.id
    storage_type = data.hpegl_vmaas_instance_disk_type.vmware_thin.id
    controller   = data.hpegl_vmaas_instance_storage_controller.scsi_0.id
  }

  labels = ["test_label"]
  tags = {
    key  = "value"
    name = "data"
    some = "random"
  }

  config {
    resource_pool_id = data.hpegl_vmaas_resource_pool.cl_resource_pool.id
    template_id      = data.hpegl_vmaas_template.vanilla.id
    no_agent         = true
    asset_tag        = "vm_tag"
    folder_code      = data.hpegl_vmaas_cloud_folder.compute_folder.code
    create_user      = true
  }
  hostname = "tf_host_1"
  scale    = 2
  evars = {
    proxy = "http://address:port"
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
  # Restarts the instance if set to any positive integer.
  # Restart works only on pre-created instance.`,
  restart_instance = 1
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

- `cloud_id` (Number) Unique ID to identify a cloud.
- `config` (Block Set, Min: 1) Configuration details for the instance to be provisioned. (see [below for nested schema](#nestedblock--config))
- `group_id` (Number) Unique ID to identify a group.
- `instance_type_code` (String) Unique code to identify the instance type.
- `layout_id` (Number) Unique ID to identify a layout.
- `name` (String) Name of the instance to be provisioned.
- `network` (Block List, Min: 1, Max: 5) Details of the network to which the instance should belong. (see [below for nested schema](#nestedblock--network))
- `plan_id` (Number) Unique ID to identify a plan.
- `volume` (Block List, Min: 1) A list of volumes to be created inside a provisioned instance.
				It can have a root volume and other secondary volumes. (see [below for nested schema](#nestedblock--volume))

### Optional

- `env_prefix` (String) Environment prefix
- `environment_code` (String) Environment code, which can be obtained via
				hpegl_vmaas_environment.code
- `evars` (Map of String) Environment Variables to be added to the provisioned instance.
- `hostname` (String) Hostname for the instance
- `labels` (List of String) An array of strings for labelling instance.
- `port` (Block List) Provide port for the instance (see [below for nested schema](#nestedblock--port))
- `power` (String) Power operation for an instance. Power attribute can be
				used to update the power state of an existing instance. Allowed power operations are
				'poweroff', 'poweron' and 'suspend'. While creating an instance only 'poweron' operation is allowed.
- `power_schedule_id` (Number) Scheduled power operations
- `restart_instance` (Number) Restarts the instance if set to any positive integer.
				Restart works only on pre-created instance.
- `scale` (Number) Number of nodes within an instance.
- `snapshot` (Block Set, Max: 1) Details for the snapshot to be created. Note that Snapshot name and description
				 should be unique for each snapshot. Any change in name or description will result in the
				 creation of a new snapshot. (see [below for nested schema](#nestedblock--snapshot))
- `tags` (Map of String) A list of key and value pairs used to tag instances of similar type.

### Read-Only

- `containers` (List of Object) Container's details for the instance which contains IP addresses, hostname and other stats (see [below for nested schema](#nestedatt--containers))
- `history` (List of Object) History details for the instance (see [below for nested schema](#nestedatt--history))
- `id` (String) The ID of this resource.
- `server_id` (Number) Unique ID to identify a server.
- `status` (String) Status of the instance.

<a id="nestedblock--config"></a>
### Nested Schema for `config`

Required:

- `folder_code` (String) Folder in which all VMs to be spawned, use hpegl_vmaas_cloud_folder.code datasource
- `resource_pool_id` (Number) Unique ID to identify a resource pool.

Optional:

- `asset_tag` (String) Asset tag
- `create_user` (Boolean) Create user
- `no_agent` (Boolean) If true agent will not be installed on the instance.
- `template_id` (Number) Unique ID for the template


<a id="nestedblock--network"></a>
### Nested Schema for `network`

Required:

- `id` (Number) Unique ID to identify a network ID.

Optional:

- `interface_id` (Number) Unique ID to identify a network interface type.

Read-Only:

- `internal_id` (Number) Unique ID to identify a network internal ID.
- `is_primary` (Boolean) Flag that identifies if a given network is primary. Primary network cannot be deleted.
- `name` (String) name of the interface


<a id="nestedblock--volume"></a>
### Nested Schema for `volume`

Required:

- `datastore_id` (String) Datastore ID can be obtained from hpegl_vmaas_datastore
							data source. Use the value 'auto' so that the datastore is automatically selected.
- `name` (String) Unique name for the volume.
- `size` (Number) Size of the volume in GB.

Optional:

- `controller` (String) Storage controller ID can be obtained from hpegl_vmaas_instance_storage_controller
							data source. Can not be customized for the first volume. This field can not be updated once volume is created.
- `root` (Boolean) true if volume is root
- `storage_type` (Number) Storage type ID can be obtained from hpegl_vmaas_instance_disk_type
							data source.

Read-Only:

- `id` (Number) ID for the volume


<a id="nestedblock--port"></a>
### Nested Schema for `port`

Required:

- `lb` (String) Load balancing configuration for ports.
					 Supported values are "No LB", "HTTP", "HTTPS", "TCP"
- `name` (String) Name of the port
- `port` (String) Port value in string


<a id="nestedblock--snapshot"></a>
### Nested Schema for `snapshot`

Required:

- `name` (String) Name of the snapshot.

Optional:

- `description` (String) Description of the snapshot
- `id` (Number) ID of the snapshot.
- `is_snapshot_exists` (Boolean) Flag which will be set to be true if the snapshot with the name
							exists.


<a id="nestedatt--containers"></a>
### Nested Schema for `containers`

Read-Only:

- `container_type` (Set of Object) (see [below for nested schema](#nestedobjatt--containers--container_type))
- `external_fqdn` (String)
- `hostname` (String)
- `id` (Number)
- `ip` (String)
- `max_cores` (Number)
- `name` (String)
- `server` (Set of Object) (see [below for nested schema](#nestedobjatt--containers--server))

<a id="nestedobjatt--containers--container_type"></a>
### Nested Schema for `containers.container_type`

Read-Only:

- `name` (String)


<a id="nestedobjatt--containers--server"></a>
### Nested Schema for `containers.server`

Read-Only:

- `compute_server_type` (Set of Object) (see [below for nested schema](#nestedobjatt--containers--server--compute_server_type))
- `date_created` (String)
- `id` (Number)
- `last_updated` (String)
- `owner` (Set of Object) (see [below for nested schema](#nestedobjatt--containers--server--owner))
- `platform` (String)
- `platform_version` (String)
- `server_os` (Set of Object) (see [below for nested schema](#nestedobjatt--containers--server--server_os))
- `ssh_host` (String)
- `ssh_port` (Number)
- `visibility` (String)

<a id="nestedobjatt--containers--server--compute_server_type"></a>
### Nested Schema for `containers.server.compute_server_type`

Read-Only:

- `external_delete` (Boolean)
- `managed` (Boolean)
- `name` (String)


<a id="nestedobjatt--containers--server--owner"></a>
### Nested Schema for `containers.server.owner`

Read-Only:

- `username` (String)


<a id="nestedobjatt--containers--server--server_os"></a>
### Nested Schema for `containers.server.server_os`

Read-Only:

- `name` (String)




<a id="nestedatt--history"></a>
### Nested Schema for `history`

Read-Only:

- `account_id` (Number)
- `created_by` (Set of Object) (see [below for nested schema](#nestedobjatt--history--created_by))
- `date_created` (String)
- `display_name` (String)
- `duration` (Number)
- `end_date` (String)
- `id` (Number)
- `instance_id` (Number)
- `last_updated` (String)
- `percent` (Number)
- `process_type` (Set of Object) (see [below for nested schema](#nestedobjatt--history--process_type))
- `reason` (String)
- `start_date` (String)
- `status` (String)
- `status_eta` (Number)
- `unique_id` (String)
- `updated_by` (Set of Object) (see [below for nested schema](#nestedobjatt--history--updated_by))

<a id="nestedobjatt--history--created_by"></a>
### Nested Schema for `history.created_by`

Read-Only:

- `display_name` (String)
- `username` (String)


<a id="nestedobjatt--history--process_type"></a>
### Nested Schema for `history.process_type`

Read-Only:

- `code` (String)
- `name` (String)


<a id="nestedobjatt--history--updated_by"></a>
### Nested Schema for `history.updated_by`

Read-Only:

- `display_name` (String)
- `username` (String)
