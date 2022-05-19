// (C) Copyright 2021 Hewlett Packard Enterprise Development LP

output "ip" {
  # Output the allocated IP
  value = hpegl_metal_ip.ip
}
