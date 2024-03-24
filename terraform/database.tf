resource "digitalocean_database_cluster" "mysql-cluster" {
  name = "${var.name}-database-cluster"
  engine = "mysql"
  version = "8"
  size = var.database_size
  region = var.region
  node_count = var.database_count
  private_network_uuid = digitalocean_vpc.server.id
}

resource "digitalocean_database_firewall" "mysql-cluster-firewall" {
  cluster_id = digitalocean_database_cluster.mysql-cluster.id

  rule {
    type = "tag"
    value = "${var.name}-server"
  }
}