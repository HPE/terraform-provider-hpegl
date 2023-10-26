# (C) Copyright 2020-2023 Hewlett Packard Enterprise Development LP

provider "hpegl" {
  metal {
    gl_token = false
  }
}

variable "location" {
  default = "USA:Central:AFCDCC1"
}

resource "hpegl_metal_volume" "test_vols" {
  count             = 1
  name              = "vol-${count.index}"
  size              = 20
  shareable         = true
  flavor            = "Fast"
  storage_pool      = "Storage_Pool_NVMe"
  location          = var.location
  volume_collection = "AustinCollection"
  description       = "Terraformed volume"
}
