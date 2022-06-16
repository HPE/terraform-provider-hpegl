# Copyright 2020-2022 Hewlett Packard Enterprise Development LP

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
