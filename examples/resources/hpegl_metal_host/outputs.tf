output "ips" {
  # Output a map of hostame with all the IP addresses assigned on each network.
  value = zipmap(hpegl_metal_host.terra_host.*.name, hpegl_metal_host.terra_host.*.connections)
}
