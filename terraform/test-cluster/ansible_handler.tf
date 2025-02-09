resource "local_file" "ansible_inventory" {
  filename = "../../ansible/init-instances/inventory/hosts.ini"
  content  = <<EOT
[nfs_servers]
nfs-server ansible_host=${google_compute_instance.nfs_server.network_interface.0.access_config.0.nat_ip} ansible_user=user

[masters]
%{for master in google_compute_instance.k3s-masters ~}
${master.name} ansible_host=${master.network_interface.0.access_config.0.nat_ip} ansible_user=user
%{endfor}

[workers]
%{for worker in google_compute_instance.k3s-workers ~}
${worker.name} ansible_host=${worker.network_interface.0.access_config.0.nat_ip} ansible_user=user
%{endfor}
EOT
}