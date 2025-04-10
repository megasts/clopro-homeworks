locals {
  current_date = timestamp()
  formatted_date = formatdate("DD-MM-YYYY", local.current_date)
  bucket_name = "shulgatyysv-${local.formatted_date}"
}

resource "yandex_storage_bucket" "test" {
  bucket = local.bucket_name
  max_size   = 1073741000
  acl    = "public-read"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "yandex_storage_object" "cute-cat-picture" {
  bucket = yandex_storage_bucket.test.bucket
  key    = var.object_name
  source = "./img/foto.jpg"
  acl = "public-read"
  depends_on = [yandex_storage_bucket.test]
}