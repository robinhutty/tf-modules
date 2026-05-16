variable "create_network" {
  description = "Controls whether this module creates its own (docker) network."
  type        = bool
  default     = false
}

variable "docker_network_name" {
  description = "The name of the network."
  type        = string
  default     = "tf-network"
}

variable "unbound_image" {
  description = "Specify the image: [<registry>/][<project>/]<image>."
  type        = string
  default     = "madnuttah/unbound"
}

variable "unbound_image_tag" {
  type        = string
  description = ""
  default     = "latest"
}

variable "unbound_port" {
  type        = number
  description = "TCP/UDP ports that should be proxied to the Unbound container."
  default     = 5335
}

variable "lan_domain" {
  description = "The DNS domain used on this LAN"
  type        = string
  default     = ""
}

locals {

  docker_network_name = var.create_network ? docker_network.tf[0].name : data.docker_network.tf[0].name
}

# validation {
#   condition     = var.example_required_input != "empty"
#   error_message = "TODO: This sample error message says that the var should not contain the string 'empty'."
# }
