resource "digitalocean_droplet" "server" {
  count = var.droplet_count
  image = var.droplet_image
  name = "server-${var.name}-${var.region}-${count.index +1}"
  region = var.region
  size = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.main.id]
  vpc_uuid = digitalocean_vpc.server.id
  tags = ["${var.name}-server"]

  # user_data = <<EOF
  # #cloud-config
  # packages:
  #     - nginx
  #     - postgresql
  #     - postgresql-contrib
  # runcmd:
  #     - wget -P /var/www/html https://raw.githubusercontent.com/do-community/terraform-sample-digitalocean-architectures/master/01-minimal-web-db-stack/assets/index.html
  #     - sed -i "s/CHANGE_ME/web-${var.region}-${count.index +1}/" /var/www/html/index.html
  # EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "digitalocean_firewall" "server" {
  name = "server-${var.name}-rules"
  droplet_ids = digitalocean_droplet.server.*.id

  # internal vpc
  inbound_rule {
    protocol = "tcp"
    port_range = "1-65535"
    source_addresses = [digitalocean_vpc.server.ip_range]
  }

  inbound_rule {
    protocol = "udp"
    port_range = "1-65535"
    source_addresses = [digitalocean_vpc.server.ip_range]
  }

  inbound_rule {
    protocol = "icmp"
    source_addresses = [digitalocean_vpc.server.ip_range]
  }

  outbound_rule {
    protocol = "udp"
    port_range = "1-65535"
    destination_addresses = [digitalocean_vpc.server.ip_range]
  }

  outbound_rule {
    protocol = "tcp"
    port_range = "1-65535"
    destination_addresses = [digitalocean_vpc.server.ip_range]
  }

  outbound_rule {
    protocol = "icmp"
    destination_addresses = [digitalocean_vpc.server.ip_range]
  }

  # dns
  outbound_rule {
    protocol = "udp"
    port_range = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  # http
  outbound_rule {
    protocol = "tcp"
    port_range = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  # https
  outbound_rule {
    protocol = "tcp"
    port_range = "443"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  # icmp
  outbound_rule {
    protocol = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  # trackmania
  inbound_rule {
    protocol = "tcp"
    port_range = "2350"
  }

  inbound_rule {
    protocol = "udp"
    port_range = "2350"
  }

  # ssh
  inbound_rule {
    protocol = "tcp"
    port_range = "22"
    source_addresses = [var.do_ssh_ip]
  }
}
