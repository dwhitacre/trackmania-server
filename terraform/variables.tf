# required
variable "do_token" {}
variable "do_ssh_pubkey" {}
variable "do_ssh_privkey" {}
variable "do_ssh_ip" {}
variable "tm_master_login" {}
variable "tm_master_password" {}

variable "name" {
  type = string
  default = "trackmania"
}

variable "tm_server_name" {
  type = string
  default = "Example Server"
}

variable "tm_server_owner" {
  type = string
  default = "xxx"
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

variable "database_count" {
  type = number
  default = 1
}

variable "database_size" {
  type = string
  default = "db-s-1vcpu-1gb"
}
