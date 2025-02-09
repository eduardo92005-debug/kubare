resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_k3s_ports" {
  name    = "allow-k3s-ports"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["6443", "2379", "2380", "10250", "10251", "10252", "30000-32767"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "static_ip" {
  name   = "k3s-master-static-ip"
  region = "us-central1"
}


resource "google_compute_firewall" "nfs_firewall" {
  name    = "nfs-firewall"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["111", "2049"]
  }
  allow {
    protocol = "udp"
    ports    = ["111", "2049"]
  }
  source_ranges = ["0.0.0.0/0"]
}