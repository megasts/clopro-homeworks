locals {
  current_date = timestamp()
  formatted_date = formatdate("DD-MM-YYYY", local.current_date)
  bucket_name = "shulgatyysv-${local.formatted_date}"
}

resource "yandex_storage_bucket" "test" {
  bucket = local.bucket_name
  max_size   = 1073741000
  acl    = "public-read"
}

resource "yandex_storage_object" "cute-cat-picture" {
  bucket = yandex_storage_bucket.test.bucket
  key    = var.object_name
  source = "./img/foto1.png"
  acl = "public-read"
}