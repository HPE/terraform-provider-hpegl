// (C) Copyright 2020-2022 Hewlett Packard Enterprise Development LP

provider "hpegl" {
  metal {
    gl_token = false
  }
}

variable "location" {
  // Provide a location at which to query for resources. 
  // The format is country:region:data-center
  default = "USA:Texas:AUSL2"
}

resource "hpegl_metal_network" "pnet" {
  name        = "pnet"
  description = "A description of pnet"
  location    = var.location
  ip_pool {
    name          = "npool"
    description   = "A description of npool"
    ip_ver        = "IPv4"
    base_ip       = "10.0.0.0"
    netmask       = "/24"
    default_route = "10.0.0.1"
    sources {
      base_ip = "10.0.0.3"
      count   = 10
    }
    dns      = ["10.0.0.50"]
    proxy    = "10.0.0.60"
    no_proxy = "10.0.0.5"
    ntp      = ["10.0.0.80"]
  }
}
