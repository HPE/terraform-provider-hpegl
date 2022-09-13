# (C) Copyright 2020-2022 Hewlett Packard Enterprise Development LP

provider "hpegl" {
  metal {
    gl_token = false
  }
}

variable "location" {
  default = "USA:Central:V2DCC01"
}

resource "hpegl_metal_volume" "iscsi_volume" {
  name        = "iscsi-volume"
  size        = 5
  shareable   = true
  flavor      = "Fast"
  location    = var.location
  description = "Terraform shareable volume"
}

resource "hpegl_metal_host" "terra_host" {
  count              = 1
  name               = "tformed-${count.index}"
  image              = "ubuntu@18.04-20201102"
  machine_size       = "Medium System"
  ssh                = [hpegl_metal_ssh_key.newssh_1.id]
  networks           = ["Public", "Storage-Client"]
  network_route      = "Public"
  location           = var.location
  description        = "Hello from Terraform"
  volume_attachments = [hpegl_metal_volume.iscsi_volume.id]
}

# Example of Host creation with implicit dependencies
resource "hpegl_metal_ssh_key" "newssh_1" {
  name       = "newssh_1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCv03o//GEQ9/6eI1qZleyBbSndg0n5AkcKVnf5D4fEjwkWrtSIJEnROqJddEAn2XYALAk9x1AcB4Nue3q4tDG17VeK3ODo0+9Dx0LYqUTawnFWmo4X80QKr658Jmt7Enmnk5x2IrUDcNwAzALVellkBbwq7QbYUu1swSycNlNhSfGizqo/lQCNIHXyeRQ8oJxOuZkbiturXHZL389blIrTeUo53xmwE1TolVS8QzZRN8ve1GjFvpC5dl6orzi6LXDcrDcbZaxlrW+YQqyaipFRAw1DyTalrfpqxtq/Y9+Elz5xgCnUaepHN6ha/k81wtI2rySHga6pMOcJKlxaRS5OfzdrWh7oi2tEAaiq2y3pTr9hROQ2OGcMNU5gxbVU2ymeXdHVsAHMCmyKvQe0g0/fJzmNA/excogFCWDN7Spy9s2V39IbEKttyXjD/dpave7re9eFzYHA1CBEnNjMuvJj0H4tnpAETdQ6UbnjbE4JYn5eKGvnJ2w1JTfSdMK8nMcxqo4HfHWuLFuntCV9GAlWIVIvJn1pYisY8kEOtN5w6QrLTfsei96/TfssAsfhrDrVtgcgNU3EvZlC6Uaaly7D0ISFeufsxkPswu+jGNUJvGEqDiqvt05lSEZWS5viR/TOROTlicaGN9dhez/fqHcj5cnuoK1pmibK5GT7/Yf1Gw== user1@quattronetworks.com"
}

resource "hpegl_metal_network" "newpnet_1" {
  name        = "newpnet_1"
  description = "New private network 1 description"
  location    = var.location
  ip_pool {
    name          = "npool"
    description   = "New IP pool description"
    ip_ver        = "IPv4"
    base_ip       = "10.0.0.0"
    netmask       = "/24"
    default_route = "10.0.0.1"
    sources {
      base_ip = "10.0.0.3"
      count   = 10
    }
    dns      = ["10.0.0.50"]
    proxy    = "https://10.0.0.60"
    no_proxy = "10.0.0.5"
    ntp      = ["10.0.0.80"]
  }
}

resource "hpegl_metal_host" "terra_host_new_ssh" {
  count            = 2
  name             = "tformed-newssh-${count.index}"
  image            = "ubuntu@18.04-20201102"
  machine_size     = "Medium System"
  ssh              = [hpegl_metal_ssh_key.newssh_1.id]
  networks         = ["Public", hpegl_metal_network.newpnet_1.name]
  network_route    = "Public"
  network_untagged = hpegl_metal_network.newpnet_1.name
  location         = var.location
  description      = "Hello from Terraform"
  labels           = { "ServiceType" = "BMaaS" }
}
