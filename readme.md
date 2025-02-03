# 🚀 Bare Metal Kubernetes Cluster Deployment Test

## 🌍 Overview
This project demonstrates the deployment of a **bare metal Kubernetes cluster** using several open-source tools, including:

- **MetalLB** for load balancing
- **Traefik** as an ingress controller
- **KubeVIP** for virtual IP management
- **NFS server** for shared storage

The infrastructure is provisioned on **Google Cloud Platform (GCP)** Virtual Machines using **Terraform** and **Ansible**, simplifying configuration and management.

⚠️ **Disclaimer:** This project is intended solely for testing purposes and is not designed for production use.

---

## 🏗️ Project Components

### 📦 Kubernetes Cluster
A **bare metal Kubernetes cluster** deployed on GCP VMs.

### ⚖️ Load Balancing
**MetalLB** is used for load balancing and exposing services to the internet.

### 🌐 Ingress Controller
**Traefik** is deployed as the ingress controller for managing HTTP(S) traffic.

### 🏷️ VIP Management
**KubeVIP** provides Virtual IP addresses for high availability.

### 📂 Shared Storage
An **NFS server** is configured to enable shared storage across the cluster.

### 🤖 Automation Tools
- **Terraform**: Provisions infrastructure on GCP.
- **Ansible**: Configures and manages cluster components.

---

## 📌 Prerequisites
Ensure you have the following:

- ✅ A **GCP account** with a configured project
- ✅ **Google Cloud SDK (gcloud)** installed and authenticated
- ✅ **Terraform** and **Ansible** installed on your local machine
- ✅ **SSH keys** configured (`id_rsa.pub` available for injection)

---

## 🛠️ Deployment Steps

### 1️⃣ Configure Your GCP Project
Modify the Terraform configuration files in the `test-cluster` directory:
- Set your **GCP project ID**
- Configure the **service account** (if needed)
- Replace the default **SSH public key** with your own (`id_rsa.pub`)

### 2️⃣ Provision Infrastructure
Navigate to the `test-cluster` directory and run:
```bash
terraform apply
```
Once provisioning completes, note the output **IP addresses**.

### 3️⃣ Configure Ansible Projects
Execute the following in order:
```bash
# Initialize instances
ansible-playbook init-instances.yml

# Deploy k3s base https://github.com/k3s-io/k3s-ansible
# REMEMBER TO CHANGE THE VALUES TO YOUR MACHINES IN INVENTORY
ansible-playbook playbooks/site.yml -i inventory.yml

# Deploy k3s (modern method)
# REMEMBER TO CHANGE THE VALUES TO YOUR MACHINES IN MYCLUSTER/hosts
ansible-playbook site.yml -i inventory/my-cluster/hosts.ini
```

### 4️⃣ Retrieve Kubernetes Configuration
Once deployed, copy the **kubeconfig** file from the master node:
```bash
scp root@<master_ip>:/etc/rancher/k3s/k3s.yaml ~/.kube/config
```
Ensure SSH host keys are added to `known_hosts` by connecting to each VM once.

### 5️⃣ Manage the Cluster
Install **k9s** for convenient cluster management:
```bash
brew install k9s  # MacOS/Linux
choco install k9s  # Windows (via Chocolatey)
```

---

## ⚙️ Configure MetalLB
### 📌 Update the IP Pool
1. Open `k9s`, press `:` and type:
   ```bash
   ipaddresspool
   ```
2. Edit the IP pool and replace it with your **public IP range**.
3. Save the changes.

### 🖧 Apply Layer 2 Advertisement Manifest
```yaml
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: default
  namespace: metallb-system
spec:
  ipAddressPools:
    - first-pool
```
This ensures proper communication with the updated **IP pool**.

### 🔗 Expose Services
Deploy services using `LoadBalancer` type and retrieve the external IP:
```bash
kubectl get svc
```

---

## 🎯 Future Goals
✅ **Enhanced Security**: Implement security improvements in a non-production environment.
✅ **Scalability Testing**: Validate horizontal scaling capabilities.
✅ **CI/CD Integration**: Develop pipelines for Terraform & Ansible automation.
✅ **Monitoring & Logging**: Implement robust monitoring and logging solutions.
✅ **Documentation Improvements**: Continuously refine the documentation for better usability.

---

## ⚠️ Disclaimer
This project is for **experimental** and **testing purposes** only. It is **not production-ready** and lacks security measures for real-world deployments. Users must conduct thorough testing and security assessments before any production use.

---

📌 **Maintainer**: Open-source community 👨‍💻
📬 **Contributions Welcome**: Feel free to submit pull requests!

🌟 Happy Coding! 🚀

