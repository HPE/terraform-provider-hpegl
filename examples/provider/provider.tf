# Copyright 2020 Hewlett Packard Enterprise Development LP

# Set-up for terraform >= v0.13
terraform {
  required_providers {
    hpegl = {
      source  = "HPE/hpegl"
      version = ">= 0.1.0"
    }
  }
}

provider "hpegl" {
  # Provide vmaas block if you want to create vmaas resources
  vmaas {
    location   = "location"
    space_name = "space_name"
  }
}
