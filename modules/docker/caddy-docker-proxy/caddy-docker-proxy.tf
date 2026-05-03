locals {

  cdp_network_name = var.create_network ? docker_network.tf[0].name : data.docker_network.cdp[0].name
  labels = concat(
    [{ label = "email", value = var.email }, ],
    var.labels_for_metrics, # https://github.com/lucaslorentz/caddy-docker-proxy/wiki/Using-admin-route-:2019
  )

}

resource "docker_image" "cdp" {
  name = join(":", [var.cdp_image, var.cdp_image_tag])
}

resource "docker_volume" "caddy_config" {
  name = "caddy_config"
}

resource "docker_volume" "caddy_data" {
  name = "caddy_data"
}

resource "docker_container" "cdp" {
  name       = "caddy"
  hostname   = "caddy"
  domainname = var.lan_domain != "" ? var.lan_domain : null
  image      = docker_image.cdp.image_id
  privileged = false # TODO:?
  restart    = "unless-stopped"

  networks_advanced {
    name = local.cdp_network_name
  }

  env = [
    "CADDY_INGRESS_NETWORKS=${local.cdp_network_name}",
  ]

  ports {
    internal = 80
    external = 80
    protocol = "tcp"
  }

  ports {
    internal = 443
    external = 443
    protocol = "tcp"
  }

  ports {
    # for Caddy metrics
    internal = 2020
    external = 2020
    protocol = "tcp"
  }

  ports {
    internal = 443
    external = 443
    protocol = "udp" # For QUIC, see RFC9000
  }

  dynamic "labels" {
    for_each = local.labels
    content {
      label = labels.value["label"]
      value = labels.value["value"]
    }
  }

  volumes {
    volume_name    = docker_volume.caddy_config.name
    container_path = "/config"
    read_only      = false
  }

  volumes {
    volume_name    = docker_volume.caddy_data.name
    container_path = "/data"
    read_only      = false
  }

  volumes {
    container_path = "/var/run/docker.sock"
    host_path      = "/var/run/docker.sock"
    read_only      = false
  }

  # wait = true # This _requires_ healthcheck
  # healthcheck {
  #   # https://docs.docker.com/reference/dockerfile/#healthcheck
  #   interval       = "10s"
  #   retries        = 3
  #   start_interval = "30s"
  #   start_period   = "20s"
  #   test           = ["CMD", "curl", "localhost/metrics"]
  # }

}
