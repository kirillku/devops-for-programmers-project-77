resource "digitalocean_droplet" "web1" {
  name     = "web1"
  image    = "docker-20-04"
  region   = "fra1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [data.digitalocean_ssh_key.ssh1.id]
}

resource "digitalocean_droplet" "web2" {
  name     = "web2"
  image    = "docker-20-04"
  region   = "fra1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [data.digitalocean_ssh_key.ssh1.id]
}

resource "digitalocean_database_db" "db1" {
  cluster_id = digitalocean_database_cluster.dbc1.id
  name       = "db1"
}

resource "digitalocean_database_cluster" "dbc1" {
  name       = "dbc1"
  engine     = "pg"
  version    = "15"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
}

resource "digitalocean_domain" "domain1" {
  name = var.website
}

resource "digitalocean_record" "www" {
  name   = "www"
  domain = digitalocean_domain.domain1.id
  type   = "A"
  value  = digitalocean_loadbalancer.loadbalancer1.ip
}

resource "digitalocean_certificate" "cert1" {
  name    = "cert1"
  type    = "lets_encrypt"
  domains = [digitalocean_domain.domain1.name]
}

resource "digitalocean_loadbalancer" "loadbalancer1" {
  name                   = "loadbalancer1"
  region                 = "fra1"
  redirect_http_to_https = true

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 80
    target_protocol = "http"

    certificate_name = digitalocean_certificate.cert1.name
  }

  healthcheck {
    port     = 80
    protocol = "tcp"
  }

  droplet_ids = [
    digitalocean_droplet.web1.id,
    digitalocean_droplet.web2.id
  ]
}

resource "local_file" "inventory" {
  content  = <<-EOT
    [webservers]
    ${digitalocean_droplet.web1.ipv4_address} server_name=web1 ansible_ssh_user=root
    ${digitalocean_droplet.web2.ipv4_address} server_name=web2 ansible_ssh_user=root

    [webservers:vars]
    db_host="${digitalocean_database_cluster.dbc1.host}"
    db_port="${digitalocean_database_cluster.dbc1.port}"
    db_name="${digitalocean_database_db.db1.name}"
    db_username="${digitalocean_database_cluster.dbc1.user}"
    db_password="${digitalocean_database_cluster.dbc1.password}"
  EOT
  filename = "../ansible/inventory.ini"
}
