resource "digitalocean_vpc" "server" {
  name = "server-${var.name}-vpc"
  region = var.region
  ip_range = "192.168.32.0/24"
}