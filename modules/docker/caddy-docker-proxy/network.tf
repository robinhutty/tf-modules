resource "docker_network" "tf" {
  count = var.create_network ? 1 : 0
  # Why? https://docs.docker.com/engine/network/drivers/bridge/#differences-between-user-defined-bridges-and-the-default-bridge
  name       = "tf-network"
  attachable = true
  driver     = "bridge"
  # ipv6       = true # https://github.com/lucaslorentz/caddy-docker-proxy/tree/v2.12.0#basic-usage-example-docker-compose
}
