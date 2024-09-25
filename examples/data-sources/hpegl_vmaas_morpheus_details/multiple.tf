# (C) Copyright 2024 Hewlett Packard Enterprise Development LP

# Location 1
provider "hpegl" {
  vmaas {
    location   = var.location_1
    space_name = var.space_1
  }

  alias = "location_1"
}

data "hpegl_vmaas_morpheus_details" "location_1" {
  provider = hpegl.location_1
}

provider "morpheus" {
  url          = data.hpegl_vmaas_morpheus_details.location_1.url
  access_token = data.hpegl_vmaas_morpheus_details.location_1.access_token

  alias = "morpheus_location_1"
}


# Location 2
provider "hpegl" {
  vmaas {
    location   = var.location_2
    space_name = var.space_2
  }

  alias = "location_2"
}

data "hpegl_vmaas_morpheus_details" "location_2" {
  provider = hpegl.location_2
}

provider "morpheus" {
  url          = data.hpegl_vmaas_morpheus_details.location_2.url
  access_token = data.hpegl_vmaas_morpheus_details.location_2.access_token

  alias = "morpheus_location_2"
}


