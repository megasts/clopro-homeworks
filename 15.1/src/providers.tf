terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.10.0"
}

provider "yandex" {
  service_account_key_file = file("${var.service_account_key_file}")
  folder_id = var.folder_id
}