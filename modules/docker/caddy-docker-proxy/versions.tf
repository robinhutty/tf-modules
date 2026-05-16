terraform {
  required_version = ">= 1.6"
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      # source = "registry.opentofu.org/kreuzwerker/docker"
      version = "~> 4.2.0"
    }

  }

  # backend "http" {}

}

provider "docker" {
  # host = "unix:///run/containerd/containerd.sock"
  # host = "unix:///var/run/docker.sock"
}
