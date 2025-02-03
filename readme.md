### Bare Metal Kubernetes Cluster Deployment Test

## Overview

This project demonstrates the deployment of a bare metal Kubernetes cluster using several open-source tools such as MetalLB, Traefik, and KubeVIP, along with an NFS server for shared storage. The infrastructure is provisioned on Google Cloud Platform (GCP) Virtual Machines using Terraform and Ansible, which simplifies configuration and management. This project is intended solely for testing purposes and is not designed for production use. It offers an alternative to using Proxmox, leveraging widely adopted tools and practices.

## Project Description
The project consists of the following components:

Kubernetes Cluster: A bare metal Kubernetes cluster deployed on GCP VMs.
Load Balancing: MetalLB is used for load balancing, with additional configuration adjustments to expose services to the internet.
Ingress Controller: Traefik is deployed as the ingress controller.
VIP Management: KubeVIP is utilized to provide Virtual IP addresses.
Shared Storage: An NFS server is configured to offer shared storage across the cluster.
Automation Tools: Terraform is used for provisioning infrastructure, and Ansible is used to configure and manage the cluster components.
## Usage Instructions
# Prerequisites
A GCP account with a configured project.
Google Cloud SDK (gcloud) installed and authenticated.
Terraform and Ansible installed on your local machine.
SSH keys properly configured (i.e., your id_rsa.pub is available for injection).
# Steps to Deploy
Configure Your GCP Project:
Modify the Terraform configuration files in the test-cluster-winov directory by setting your GCP project and service-account (if needed).
Replace the default SSH public key with your own by updating the corresponding file (e.g., id_rsa.pub).
# Provision Infrastructure:
Navigate to the test-cluster-winov directory.
Run the following command to apply the Terraform configuration:
bash
terraform apply
After the provisioning process completes, note the IP addresses that are output. Save these IPs in an accessible location.

## Configure Ansible Projects:
The first Ansible project to run is init-instances. Ensure that the IP addresses of the respective instances are correctly configured within the project files.
Next, execute the k3s-ansible-classic project, followed by the k3s-ansible project. The order of execution is important:
init-instances
k3s-ansible-classic
k3s-ansible
Obtain Kubernetes Configuration:

Once the cluster is deployed, retrieve the kubeconfig from the master VM:
bash
scp root@<master_ip>:/etc/rancher/k3s/k3s.yaml ~/.kube/config
Ensure that you have added the host keys for your VMs to your known_hosts file (this can be done by SSH-ing into each instance once).

## Cluster Management:
It is recommended to install k9s for convenient cluster management and monitoring.

## Configure MetalLB:

To expose your services externally, update the MetalLB IP pool:
Launch k9s and press : then type ipaddresspool to edit the pool configuration.
Replace the default IP range with the public IP addresses of your instances or another available IP range.
Save the changes.
Next, apply the Layer 2 advertisement manifest to connect the L2 layer with the updated IP pool:
yaml
Copiar
Editar
apiVersion: metallb.io/v1beta1 
kind: L2Advertisement
metadata:
  name: default
  namespace: metallb-system
spec:
  ipAddressPools:
    - first-pool
This configuration will enable your L2 layer to communicate with the updated IP pool.
Expose Services:

Finally, expose your Kubernetes services using the LoadBalancer service type.
Retrieve the external IP and port from the service status.
Future Goals
Enhanced Security: Explore improvements for security features in a non-production environment.
Scalability Testing: Validate the scalability of the current configuration and test horizontal scaling scenarios.
Integration with CI/CD: Develop pipelines that integrate with Terraform and Ansible for continuous deployment and configuration management.
Monitoring and Logging: Implement comprehensive monitoring and logging solutions to provide better insight into cluster performance and potential issues.
Documentation Improvements: Continue updating and refining documentation for easier adoption by other users and administrators.
Disclaimer
This project is intended for experimental and testing purposes only. It is not guaranteed to be production-ready or secure for real-world deployments. Users are advised to conduct thorough testing and security assessments before considering any production use
