// (C) Copyright 2020-2022, 2025 Hewlett Packard Enterprise Development LP

resource "hpegl_metal_project" "project" {
  name = "blob"
  profile {
    company             = "ACME"
    address             = "Area51"
    email               = "acme@intergalactic.universe"
    phone_number        = "+112 234 1245 3245"
    project_description = "Primitive Life"
    project_name        = "Umbrella Corporation"
  }
  limits {
    hosts            = 5
    volumes          = 10
    volume_capacity  = 300
    private_networks = 20
  }
  sites = ["22473578-e18b-4753-a2e6-ba405b8abc32"]
}
