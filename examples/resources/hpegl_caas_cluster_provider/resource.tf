# Copyright 2022 Hewlett Packard Enterprise Development LP

terraform {
  required_providers {
    hpegl = {
      source  = "HPE/hpegl"
      version = ">= 0.1.0"
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

data "hpegl_caas_cluster_provider" "clusterprovider" {
  name = "ecp"
  site_id = data.hpegl_caas_site.blr.id
}

output "cluster_provider" {
  description = "The cluster provider response"
  value       = data.hpegl_caas_cluster_provider.clusterprovider.*
}
