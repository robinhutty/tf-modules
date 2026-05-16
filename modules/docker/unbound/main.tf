data "docker_network" "tf" {
  count = var.create_network ? 0 : 1
  name  = var.docker_network_name
}

resource "docker_network" "tf" {
  count = var.create_network ? 1 : 0
  # Why? https://docs.docker.com/engine/network/drivers/bridge/#differences-between-user-defined-bridges-and-the-default-bridge
  name       = "tf-network"
  attachable = true
  driver     = "bridge"
  # ipv6       = true # https://github.com/lucaslorentz/caddy-docker-proxy/tree/v2.12.0#basic-usage-example-docker-compose
}
resource "docker_image" "unbound" {
  name = join(":", [var.unbound_image, var.unbound_image_tag])
}

resource "docker_container" "unbound" {
  name       = "unbound"
  hostname   = "unbound"
  domainname = var.lan_domain != "" ? var.lan_domain : null
  image      = docker_image.unbound.image_id
  privileged = false
  restart    = "unless-stopped"

  networks_advanced {
    name = local.docker_network_name
  }

  env = [
    "TZ=America/New_York",
    "UNBOUND_UID=1000",                     #optional
    "UNBOUND_GID=1000",                     #optional
    "HEALTHCHECK_PORT=${var.unbound_port}", #optional
    "EXTENDED_HEALTHCHECK=false",           #optional
    # "EXTENDED_HEALTHCHECK_DOMAIN=<"Domain/host to query>, #optional
    "ENABLE_STATS=false", #optional
  ]

  healthcheck {
    # https://docs.docker.com/reference/dockerfile/#healthcheck
    interval       = "10s"
    retries        = 3
    start_interval = "30s"
    start_period   = "20s"
    test           = ["CMD", "/usr/local/unbound/sbin/healthcheck.sh"]
  }

  ports {
    internal = 53
    external = var.unbound_port
    protocol = "tcp"
  }

  ports {
    internal = 53
    external = var.unbound_port
    protocol = "udp"
  }

}
