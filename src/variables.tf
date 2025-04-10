variable "service_account_key_file" {
  type        = string
  description = "file_key.json"
}

variable "folder_id" {
  type = string
}

variable "service_account_id" {
  type = string
}

variable "vms_ssh_root_key" {
  type        = string
  description = "ssh-keygen -t ed25519"
}

variable "public_zone" {
  type = string
  default = "ru-central1-a"
}

variable "network_name" {
  type = string
}

variable "subnets_data" {
  type = list(object({
    zone = string,
    cidr = string
    }
    )
  )
  default = [ 
  {zone = "ru-central1-a", cidr = "192.168.1.0/24"}, 
  {zone = "ru-central1-b", cidr = "192.168.2.0/24"},
  {zone = "ru-central1-d", cidr = "192.168.3.0/24"}
  ]
  description = "List data of the zone and cidr" 
}

variable "username" {
  type = string
  default = "ubuntu"
  description = "for ubuntu"
}

variable "os_image_id" {
    type = string
}

variable "core_fraction" {
  type = number
  default = 5
}

variable "size_hdd" {
  type = number
  default = 5
}

variable "object_name" {
  type = string
  default = "foto"
}