# (C) Copyright 2020-2023 Hewlett Packard Enterprise Development LP

provider "hpegl" {
  metal {
    gl_token = false
  }
}

data "hpegl_metal_available_resources" "physical" {

}

output "locations" {
  value = data.hpegl_metal_available_resources.physical.locations
}

output "images" {
  value = data.hpegl_metal_available_resources.physical.images
}

output "ssh-keys" {
  value = data.hpegl_metal_available_resources.physical.ssh_keys
}

output "networks" {
  value = [for net in data.hpegl_metal_available_resources.physical.networks : net if net.location == var.location]
}

output "volumes" {
  value = [for vol in data.hpegl_metal_available_resources.physical.volumes : vol if vol.location == var.location]
}

output "volume-flavors" {
  value = data.hpegl_metal_available_resources.physical.volume_flavors
}

output "machine-sizes" {
  value = data.hpegl_metal_available_resources.physical.machine_sizes
}

output "storage-pools" {
  value = data.hpegl_metal_available_resources.physical.storage_pools
}

output "volume-collections" {
  value = data.hpegl_metal_available_resources.physical.volume_collections
}
