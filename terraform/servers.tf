resource "digitalocean_droplet" "server" {
  count = var.droplet_count
  image = var.droplet_image
  name = "server-${var.name}-${var.region}-${count.index +1}"
  region = var.region
  size = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.main.id]
  vpc_uuid = digitalocean_vpc.server.id
  tags = ["${var.name}-server"]

  connection {
    type = "ssh"
    user = "root"
    private_key = file(pathexpand(var.do_ssh_privkey))
    host = self.ipv4_address
  }

  provisioner "file" {
    source = "../trackmania"
    destination = "/opt" 
  }

  provisioner "remote-exec" {
    inline = [
      "cd /opt/trackmania",
      "echo \"FORCE_IP_ADDRESS=\\\"${self.ipv4_address}:2350\\\"\" >> /opt/trackmania/trackmania.env",
      "docker compose up -d"
    ]
  }

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
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol = "udp"
    port_range = "2350"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # ssh
  inbound_rule {
    protocol = "tcp"
    port_range = "22"
    source_addresses = [var.do_ssh_ip]
  }
}
