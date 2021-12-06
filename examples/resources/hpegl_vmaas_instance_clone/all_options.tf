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
