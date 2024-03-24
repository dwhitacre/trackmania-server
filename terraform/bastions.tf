resource "digitalocean_droplet" "bastion" {
  image = var.bastion_image
  name = "bastion-${var.name}-${var.region}"
  region = var.region
  size = var.bastion_size
  ssh_keys = [data.digitalocean_ssh_key.main.id]
  vpc_uuid = digitalocean_vpc.server.id
}

resource "digitalocean_firewall" "bastion" {
  name = "bastion-${var.name}-rules"
  droplet_ids = [digitalocean_droplet.bastion.id]

  # ssh
  inbound_rule {
    protocol = "tcp"
    port_range = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # vpc
  outbound_rule {
    protocol = "tcp"
    port_range = "22"
    destination_addresses = [digitalocean_vpc.server.ip_range]
  }

  outbound_rule {
    protocol = "icmp"
    destination_addresses = [digitalocean_vpc.server.ip_range]
  }
}