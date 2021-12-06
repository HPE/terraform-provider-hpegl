# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

# minimal instance creation
resource "hpegl_vmaas_instance_clone" "minimal_instance" {
  name               = "tf_minimal_clone"
  source_instance_id = hpegl_vmaas_instance.tf_instance.id
  network {
    id = data.hpegl_vmaas_network.blue_net.id
  }
}
