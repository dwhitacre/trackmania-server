data "digitalocean_ssh_key" "main" {
  name = var.do_ssh_pubkey
}
