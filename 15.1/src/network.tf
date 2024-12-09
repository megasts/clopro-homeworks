resource "yandex_vpc_network" "my-net" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "public" {
  network_id     = yandex_vpc_network.my-net.id
  name           = var.name_public_subnet
  zone           = var.public_zone
  v4_cidr_blocks = [var.public_cidr]
}

resource "yandex_vpc_route_table" "nat-instance-route" {
  name       = "nat-instance-route"
  network_id = yandex_vpc_network.my-net.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.nat-instance.network_interface.0.ip_address
  }
}

resource "yandex_vpc_subnet" "private" {
  network_id     = yandex_vpc_network.my-net.id
  name           = var.name_private_subnet
  zone           = var.private_zone
  v4_cidr_blocks = [var.private_cidr]
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}