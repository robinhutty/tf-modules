variable "create_network" {
  description = "Controls whether this module creates its own (docker) network."
  type        = bool
  default     = true
}

variable "cdp_network_name" {
  description = "The name of the network."
  type        = string
  default     = "tf-network"
}

variable "cdp_image" {
  description = "Specify the image: [<registry>/][<project>/]<image>."
  type        = string
  default     = "lucaslorentz/caddy-docker-proxy"
}

variable "cdp_image_tag" {
  description = "See https://github.com/lucaslorentz/caddy-docker-proxy/tree/v2.12.0#docker-images"
  type        = string
  default     = "2.12.0-alpine"
}

variable "labels_for_metrics" {
  description = "Labels required for Prometheus metrics"
  type        = list(map(string))
  default = [
    { label = "metrics", value = "" },
    { label = "caddy", value = ":2020" },
    { label = "caddy.reverse_proxy", value = "localhost:2019" },
    { label = "caddy.reverse_proxy.0_header_up", value = "-Host" },
    { label = "caddy.reverse_proxy.1_header_up", value = "-X-*" },
  ]
}

variable "labels" {
  description = "A map of map of label,value pairs that get applied as container labels."
  type        = list(map(string))
  default     = [{}]
}

variable "email" {
  description = "Email that gets passed to letsencrypt"
  type        = string
  default     = "foo@example.com"
}

variable "lan_domain" {
  description = "The DNS domain used on this LAN"
  type        = string
  default     = ""
}
