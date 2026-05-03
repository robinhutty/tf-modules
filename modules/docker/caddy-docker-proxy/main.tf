# data source lookups for caddy-proxy
data "docker_network" "cdp" {
  count = var.create_network ? 0 : 1
  name  = var.cdp_network_name
}
