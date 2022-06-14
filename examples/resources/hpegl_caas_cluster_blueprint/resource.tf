# Copyright 2022 Hewlett Packard Enterprise Development LP

terraform {
  required_providers {
    hpegl = {
      # We are specifying a location that is specific to the service under development
      # In this example it is caas (see "source" below).  The service-specific replacement
      # to caas must be specified in "source" below and also in the Makefile as the
      # value of DUMMY_PROVIDER.
      source  = "terraform.example.com/caas/hpegl"
      version = ">= 0.0.1"
    }
  }
}

provider hpegl {
  caas {
    api_url = "https://mcaas.intg.hpedevops.net/mcaas"
  }
}

data "hpegl_caas_site" "blr" {
  name = "BLR"
  space_id = ""
}

data "hpegl_caas_machine_blueprint" "mbcontrolplane" {
  name = "standard-master"
  site_id = data.hpegl_caas_site.blr.id
}

data "hpegl_caas_machine_blueprint" "mbworker" {
  name = "standard-worker"
  site_id = data.hpegl_caas_site.blr.id
}

data "hpegl_caas_cluster_provider" "clusterprovider" {
  name = "ecp"
  site_id = data.hpegl_caas_site.blr.id
}

resource hpegl_caas_cluster_blueprint testbp {
  name         = "tf-cluster-bp"
  k8s_version  = data.hpegl_caas_cluster_provider.clusterprovider.k8s_versions[0]
  default_storage_class = ""
  site_id = data.hpegl_caas_site.blr.id
  cluster_provider = ""
  control_plane_nodes = {
    machine_blueprint_id = data.hpegl_caas_machine_blueprint.mbcontrolplane.id
    count = ""
  }
  worker_nodes {
      name = ""
      machine_blueprint_id = data.hpegl_caas_machine_blueprint.mbworker.id
      count = ""
    }
  worker_nodes {
        name = ""
        machine_blueprint_id = data.hpegl_caas_machine_blueprint.mbworker.id
        count = ""
      }
}
