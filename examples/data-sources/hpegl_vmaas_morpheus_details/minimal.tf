# (C) Copyright 2024 Hewlett Packard Enterprise Development LP

data "hpegl_vmaas_morpheus_details" "morpheus_details" {}

provider "morpheus" {
  url          = data.hpegl_vmaas_morpheus_details.morpheus_details.url
  access_token = data.hpegl_vmaas_morpheus_details.morpheus_details.access_token
}


