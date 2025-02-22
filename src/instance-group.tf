resource "yandex_vpc_network" "my-net" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "my_subnet" {
  count          =  3
  v4_cidr_blocks = ["${var.subnets_data[count.index].cidr}"]
  zone           = "${var.subnets_data[count.index].zone}"
  network_id     = "${yandex_vpc_network.my-net.id}"
  name           = "public-${count.index+1}"
}

resource "yandex_compute_instance_group" "group1" {
  name                = "test-ig"
  folder_id           = var.folder_id
  service_account_id  = var.service_account_id
  deletion_protection = false
  
  variables = {
    short_zone_var_ru-central1-a = "rc1a"
    short_zone_var_ru-central1-b = "rc1b"
    short_zone_var_ru-central1-d = "rc1d"
  }

  instance_template {
    name = "production-{short_zone_var_{instance.zone_id}}-{instance.index}"
    hostname = "production-{instance.index}"
    platform_id = "standard-v2"
    
    resources {
      memory = 1
      cores  = 2
      core_fraction = var.core_fraction
    }

    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.vm-os-image.image_id
        type     = "network-hdd"
        size     = var.size_hdd
      }
    }

    scheduling_policy { preemptible = true }

    network_interface {
      subnet_ids   = ["${yandex_vpc_subnet.my_subnet[0].id}", "${yandex_vpc_subnet.my_subnet[1].id}", "${yandex_vpc_subnet.my_subnet[2].id}"]
      nat         = true
    }

    metadata = {
      user-data           = data.template_file.cloudinit.rendered
      serial-port-enable  = 1
    }
    
    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = [var.subnets_data[0].zone, var.subnets_data[1].zone, var.subnets_data[2].zone]
  }

  deploy_policy {
    max_unavailable = 3
    max_creating    = 3
    max_expansion   = 3
    max_deleting    = 3
  }

  health_check {
    interval = 2
    timeout = 1
    unhealthy_threshold = 2
    healthy_threshold = 2
    http_options {
      port = 80
      path = "/"
    }
  }
}

data "yandex_compute_image" "vm-os-image" {
  image_id = var.os_image_id
}


data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    username        = var.username
    ssh_public_key  = file(var.vms_ssh_root_key)
    bucket_name     = local.bucket_name
    object_name     = var.object_name
  }
}
