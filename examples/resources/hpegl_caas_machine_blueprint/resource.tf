# Copyright 2020-2022 Hewlett Packard Enterprise Development LP

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

resource hpegl_caas_machine_blueprint test {
 name = ""
 site_id = data.hpegl_caas_site.blr.id
 machine_roles = ["controlplane"]
 machine_provider = "vmaas"
 os_image = "sles-custom"
 os_version = ""
 compute_type = ""
 size = ""
 storage_type = ""
}