# Copyright 2020-2023 Hewlett Packard Enterprise Development LP

terraform {
  required_providers {
    hpegl = {
      source  = "HPE/hpegl"
      version = ">= 0.1.0"
    }
  }
}

provider "hpegl" {
  caas {
  }
}

variable "HPEGL_SPACE" {
  type = string
}

data "hpegl_caas_site" "blr" {
  name     = "BLR"
  space_id = var.HPEGL_SPACE
}

resource "hpegl_caas_machine_blueprint" "test" {
  name             = ""
  site_id          = data.hpegl_caas_site.blr.id
  machine_roles    = ["controlplane"]
  machine_provider = "vmaas"
  worker_type      = ""
  compute_type     = ""
  size             = ""
  storage_type     = ""
}