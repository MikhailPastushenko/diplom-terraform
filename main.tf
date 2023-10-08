
locals {
  env = terraform.workspace
}

# VPC-network
resource "yandex_vpc_network" "vpc-network" {
  name = "vpc-network"
}

# public subnet
resource "yandex_vpc_subnet" "public-subnet" {
  name           = "public-subnet-${local.env}"
  zone           = var.YC_ZONE
  network_id     = yandex_vpc_network.vpc-network.id
  v4_cidr_blocks = (local.env == "prod" ? ["192.168.10.0/24"] : ["192.168.30.0/24"] )
}

# private subnet
resource "yandex_vpc_subnet" "private-subnet" {
  name           = "private-subnet-${local.env}"
  zone           = var.YC_ZONE
  network_id     = yandex_vpc_network.vpc-network.id
  v4_cidr_blocks = (local.env == "prod" ? ["192.168.20.0/24"] : ["192.168.40.0/24"] )
}

## kubernetes cluster VMs


# master node
resource "yandex_compute_instance" "master" {
  name = "master-${local.env}"
  hostname = "master-${local.env}"
  zone     = var.YC_ZONE
  platform_id = "standard-v3"
  resources {
    cores  = 2
    memory = 2
    core_fraction = 100
  }
  boot_disk {
    initialize_params {
      image_id = "fd80bm0rh4rkepi5ksdi"
      size = 50
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public-subnet.id
    nat = true  
  }
  metadata = {
    user-data = "${file("meta.yaml")}"
    serial-port-enable = 1
  }
}


# worker node
resource "yandex_compute_instance" "worker1" {
  name = "worker1-${local.env}"
  hostname = "worker1-${local.env}"
  zone     = var.YC_ZONE
  platform_id = "standard-v3"
  resources {
    cores  = 2
    memory = 2
    core_fraction = 100
  }
  boot_disk {
    initialize_params { 
      image_id = "fd80bm0rh4rkepi5ksdi"
      size = 50
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public-subnet.id
    nat = true
  }
  metadata = {
    user-data = "${file("meta.yaml")}"
    serial-port-enable = 1
  }
}

# worker node
resource "yandex_compute_instance" "worker2" {
  name = "worker2-${local.env}"
  hostname = "worker2-${local.env}"
  zone     = var.YC_ZONE
  platform_id = "standard-v3"
  resources {
    cores  = 2
    memory = 2
    core_fraction = 100
  }
  boot_disk {
    initialize_params {
      image_id = "fd80bm0rh4rkepi5ksdi"
      size = 50
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public-subnet.id
    nat = true
  }
  metadata = {
    user-data = "${file("meta.yaml")}"
    serial-port-enable = 1
  }
}

