# required
variable "do_token" {}
variable "do_ssh_pubkey" {}

variable "name" {
  type = string
  default = "trackmania"
}

variable "region" {
  type    = string
  default = "nyc3"
}

variable "droplet_count" {
  type = number
  default = 1
}

# https://slugs.do-api.dev/
variable "droplet_size" {
  type = string
  default = "s-1vcpu-1gb"
}

variable "droplet_image" {
  type = string
  default = "docker-20-04"
}

variable "bastion_size" {
  type = string
  default = "s-1vcpu-1gb"
}

variable "bastion_image" {
  type = string
  default = "ubuntu-22-04-x64"
}

variable "database_count" {
  type = number
  default = 1
}

variable "database_size" {
  type = string
  default = "db-s-1vcpu-1gb"
}
