resource "google_compute_instance" "k3s-masters" {
  for_each     = { for idx, inst in var.instances_masters : inst.name => inst }
  name         = each.value.name
  machine_type = each.value.machine_type
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }
  
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }

  metadata = {
    ssh-keys = "user:${file("C:/Users/Eduardo/.ssh/id_rsa.pub")}"
  }


  service_account {
    email  = "843462201394-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}



resource "google_compute_instance" "k3s-workers" {
  for_each     = { for idx, inst in var.instances_workers : inst.name => inst }
  name         = each.value.name
  machine_type = each.value.machine_type
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }
  
  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "user:${file("C:/Users/Eduardo/.ssh/id_rsa.pub")}"
  }


  service_account {
    email  = "843462201394-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}


resource "google_compute_instance" "nfs_server" {
  name         = "nfs-server"
  machine_type = "f1-micro"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }


  metadata = {
    ssh-keys = "user:${file("C:/Users/Eduardo/.ssh/id_rsa.pub")}"
  }

  service_account {
    email  = "843462201394-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}


