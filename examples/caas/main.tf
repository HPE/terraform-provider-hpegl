# Copyright 2022 Hewlett Packard Enterprise Development LP

# Set-up for terraform >= v0.13
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

resource hpegl_caas_cluster test {
  name         = var.cluster_name
  blueprint_id = "b6cece94-8560-40d6-923b-4c3d0319bc99"
  appliance_id = "3ad9c737-5bb6-430c-9772-3a6f5a7e4015"
  space_id     = "aadc51f2-8b3f-4ae0-aff2-820f7169447f"
}
