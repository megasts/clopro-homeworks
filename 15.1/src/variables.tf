variable "service_account_key_file" {
  type        = string
  description = "file_key.json"
}

variable "folder_id" {
    type = string
}

variable "network_name" {
  type = string
  default = "netology"
}

variable "name_public_subnet" {
  type = string
  default = "public"
}

variable "public_zone" {
  type = string
  default = "ru-central1-d"
  description = "for new project"
}

variable "public_cidr" {
  type = string
  default = "10.0.1.0/24"
}

variable "nat_image_id" {
  type = string
  default = "fd80mrhj8fl2oe87o4e1"
}

variable "vm_nat_name" {
  type = string
  default = "nat_vm"
}

variable "nat_core_fraction" {
  type = number
  default = 20
}

variable "nat_username" {
    type = string
    default = "ubuntu"
    description = "for ubuntu"
}

variable "vm_username" {
    type = string
    default = "ubuntu"
    description = "for ubuntu"
}

variable "vms_ssh_root_key" {
    type        = string
    description = "ssh-keygen -t ed25519"
}

variable "nat_vm_ip_address" {
    type = string
}

variable "public_vm_name" {
    default = "public"
    type = string
}

variable "family_os" {
    type = string
    default = "ubuntu-2404-lts-oslogin" 
}

variable "vm_core_fraction" {
    type = number
    default = 20
}

variable "private_zone" {
  type = string
  default = "ru-central1-d"
  description = "for new project"
}

variable "name_private_subnet" {
    type = string
    default = "private"
}

variable "private_cidr" {
    type = string
    default = "10.0.2.0/24"
}

variable "private_vm_name" {
    type = string
    default = "private-vm"
}