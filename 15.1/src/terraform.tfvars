    network_name     = "netmegion"
    name_public_subnet = "public"
    public_zone = "ru-central1-d"
    nat_image_id = "fd80mrhj8fl2oe87o4e1"
    public_cidr = "192.168.10.0/24"
    
    vm_nat_name = "nat-instance"
    nat_core_fraction = 5
    nat_vm_ip_address = "192.168.10.254"
    
    public_vm_name = "public-vm"
    vm_core_fraction = 5

    name_private_subnet = "private"
    private_zone = "ru-central1-d"
    private_cidr = "192.168.20.0/24"

    private_vm_name = "private-vm"
   