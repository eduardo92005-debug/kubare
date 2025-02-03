output "instance_ips_workers" {
  value = { for inst in google_compute_instance.k3s-workers : inst.name => inst.network_interface[0].access_config[0].nat_ip }
}

output "instance_ips_masters" {
  value = { for inst in google_compute_instance.k3s-masters : inst.name => inst.network_interface[0].access_config[0].nat_ip }
}

output "nfs_server_ip" {
  value = google_compute_instance.nfs_server.network_interface[0].access_config[0].nat_ip
}
