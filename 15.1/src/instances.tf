
data "yandex_compute_image" "nat-os-image" {
  image_id = var.nat_image_id
}

data "template_file" "nat_cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    username           = var.nat_username
    ssh_public_key     = file(var.vms_ssh_root_key)
  }
}

resource "yandex_compute_instance" "nat-instance" {
  name        = var.vm_nat_name
  platform_id = "standard-v2"
  zone = var.public_zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = var.nat_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.nat-os-image.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    ip_address = var.nat_vm_ip_address
    nat       = true
  }

  metadata = {
    user-data = data.template_file.nat_cloudinit.rendered
    serial-port-enable = 1
  }
}


data "yandex_compute_image" "vm-os-image" {
  family = var.family_os  
}

data "template_file" "vm_cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    username           = var.vm_username
    ssh_public_key     = file(var.vms_ssh_root_key)
  }
}

resource "yandex_compute_instance" "private-vm-instance" {
  name        = var.private_vm_name
  platform_id = "standard-v2"
  zone = var.private_zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = var.vm_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.vm-os-image.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
    nat       = false
  }

  metadata = {
    user-data = data.template_file.nat_cloudinit.rendered
    serial-port-enable = 1
  }
}

resource "yandex_compute_instance" "public-vm-instance" {
  name        = var.public_vm_name
  platform_id = "standard-v2"
  zone = var.public_zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = var.vm_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.vm-os-image.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }

  metadata = {
    user-data = data.template_file.nat_cloudinit.rendered
    serial-port-enable = 1
  }
}

