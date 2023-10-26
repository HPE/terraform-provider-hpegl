# (C) Copyright 2020-2023 Hewlett Packard Enterprise Development LP

variable "location" {
  // Provide a location at which to query for resources. The default given here
  // is compatible with the portal-simulator.
  // the format is country:region:data-center
  default = "USA:Central:AFCDCC1"
}
