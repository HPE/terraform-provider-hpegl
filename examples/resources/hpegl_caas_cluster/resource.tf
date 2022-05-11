# Copyright 2020 Hewlett Packard Enterprise Development LP

terraform {
  required_providers {
    hpegl = {
      source  = "terraform.example.com/caas/hpegl"
      version = ">= 0.0.1"
    }
  }
}

provider hpegl {
  caas {
    api_url = "https://mcaas.intg.hpedevops.net/mcaas/v1"
  }
}

data "hpegl_caas_cluster_blueprint" "bp" {
  name = "demo"
  space_id = ""
}

data "hpegl_caas_appliance" "blr" {
  name = "BLR"
  space_id = ""
}

resource hpegl_caas_cluster test {
  name         = "tf-test"
  blueprint_id = data.hpegl_caas_cluster_blueprint.bp.id
  appliance_id = data.hpegl_caas_appliance.blr.id
  space_id     = ""
}
