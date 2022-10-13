output "ips" {
  # Output a map of hostname with each network's IP address.
  value = zipmap(hpegl_metal_host.terra_host.*.name, hpegl_metal_host.terra_host.*.connections)
}

output "subnets" {
  # Output a map of hostname with each network's subnet address.
  value = zipmap(hpegl_metal_host.terra_host.*.name, hpegl_metal_host.terra_host.*.connections_subnet)
}

output "gateways" {
  # Output a map of hostname with each network's gateway address.
  value = zipmap(hpegl_metal_host.terra_host.*.name, hpegl_metal_host.terra_host.*.connections_gateway)
}

output "vlans" {
  # Output a map of hostname with each network's vlan.
  value = zipmap(hpegl_metal_host.terra_host.*.name, hpegl_metal_host.terra_host.*.connections_vlan)
}



