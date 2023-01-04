# Copyright 2020-2022 Hewlett Packard Enterprise Development LP

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
    api_url = "https://mcaas.intg.hpedevops.net/mcaas"
  }
}

variable "HPEGL_SPACE" {
  type = string
}

data "hpegl_caas_site" "blr" {
  name     = "BLR"
  space_id = var.HPEGL_SPACE
}

data "hpegl_caas_cluster_blueprint" "bp" {
  name    = "demo"
  site_id = data.hpegl_caas_site.blr.id
}

data "hpegl_caas_machine_blueprint" "mbworker" {
  name    = "standard-worker"
  site_id = data.hpegl_caas_site.blr.id
}

resource "hpegl_caas_cluster" "test" {
  name         = "tf-test"
  blueprint_id = data.hpegl_caas_cluster_blueprint.bp.id
  site_id      = data.hpegl_caas_site.blr.id
  space_id     = var.HPEGL_SPACE

  worker_nodes {
    name                 = "test-node-pool"
    machine_blueprint_id = data.hpegl_caas_machine_blueprint.mbworker.id
    count                = "1"
  }
}