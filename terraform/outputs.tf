output "tm_servers_private" {
  value = digitalocean_droplet.server.*.ipv4_address_private
}

output "tm_servers_public" {
  value = digitalocean_droplet.server.*.ipv4_address
}

output "bastion_public" {
  value = digitalocean_droplet.bastion.ipv4_address
}

output "database_port" {
  value = digitalocean_database_cluster.mysql-cluster.port
}

output "database_private_uri" {
  value = digitalocean_database_cluster.mysql-cluster.private_uri
  sensitive = true
}

output "database_name" {
  value = digitalocean_database_cluster.mysql-cluster.database
}

output "database_user" {
  value = digitalocean_database_cluster.mysql-cluster.user
}

output "database_password" {
  value = digitalocean_database_cluster.mysql-cluster.password
  sensitive = true
}