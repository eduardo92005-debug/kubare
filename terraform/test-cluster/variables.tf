variable "instances_masters" {
  type = list(object({
    name         = string
    machine_type = string
  }))
  default = [
    { name = "k3s-master", machine_type = "e2-medium" }
  ]
}

variable "instances_workers" {
  type = list(object({
    name         = string
    machine_type = string
  }))
  default = [
    { name = "k3s-node-1", machine_type = "e2-medium" },
    { name = "k3s-node-2", machine_type = "e2-medium" }
  ]
}

variable "service_accout_email" {
  type = string
  sensitive = true
}

variable "pub_directory" {
  type = string
}