resource "yandex_lb_target_group" "nlb_tg" {
  name      = "nlb-target-group"

  target {
    subnet_id = yandex_compute_instance_group.group1.instances.0.network_interface.0.subnet_id
    address   = yandex_compute_instance_group.group1.instances.0.network_interface.0.ip_address
    }
  
  target {
    subnet_id = yandex_compute_instance_group.group1.instances.1.network_interface.0.subnet_id
    address   = yandex_compute_instance_group.group1.instances.1.network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_compute_instance_group.group1.instances.2.network_interface.0.subnet_id
    address   = yandex_compute_instance_group.group1.instances.2.network_interface.0.ip_address
  }
}

resource "yandex_lb_network_load_balancer" "nlb" {
  name = "network-load-balancer"

  listener {
    name = "my-listener"
    port = 80
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.nlb_tg.id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}