# Output definitions for caddy-docker-proxy
data "docker_containers" "this" {}

output "containers" {
  description = "Details about the containers managed in this module"
  value = data.docker_containers.this.containers
}
