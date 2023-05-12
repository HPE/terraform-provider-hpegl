// (C) Copyright 2023 Hewlett Packard Enterprise Development LP

resource "hpegl_metal_image" "image" {
  os_service_image_file = "./service.yml"
}
