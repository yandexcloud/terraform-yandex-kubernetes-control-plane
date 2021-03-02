terraform {
  required_providers {

    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "random_string" "token_head" {
  length  = 6
  lower   = true
  upper   = false
  number  = true
  special = false
}

resource "random_string" "token_tail" {
  length  = 16
  lower   = true
  upper   = false
  number  = true
  special = false
}

resource "random_string" "certificate_key" {
  length  = 100
  lower   = false
  upper   = false
  number  = true
  special = false
}

locals {
  token   = "${random_string.token_head.result}.${random_string.token_tail.result}"
  certkey = substr(lower(format("%X", random_string.certificate_key.id)), 0, 64)
  group   = "${var.prefix}masters"

  pod_gateway = cidrhost(var.pod_cidr, 1)
  cluster_dns = cidrhost(var.svc_cidr, 2)
}

resource "yandex_compute_instance_group" "masters" {
  folder_id          = var.folder_id
  name               = local.group
  service_account_id = var.sa

  instance_template {
    name               = "${var.prefix}-master-{instance.index}"
    hostname           = "${var.prefix}-master-{instance.index}"
    platform_id        = var.platform_id
    service_account_id = var.sa

    resources {
      cores         = var.cores
      memory        = var.memory
      core_fraction = var.core_fraction
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.image
        size     = var.boot_disk_size
        type     = var.boot_disk_type
      }
    }

    secondary_disk {
      mode        = "READ_WRITE"
      device_name = "data"
      initialize_params {
        size = var.data_disk_size
        type = var.data_disk_type
      }
    }

    network_interface {
      subnet_ids = var.subnet_ids
    }

    metadata = {
      ssh-keys           = join("\n", concat(var.ssh_keys, [tls_private_key.pk.public_key_openssh]))
      serial-port-enable = var.enable_serial_port ? 1 : 0

      user-data = templatefile("${path.module}/userdata.yml", {
        control_plane_endpoint = var.control_plane_endpoint
        name                   = var.name
        version                = var.kubernetes_version
        certificate_key        = local.certkey
        token                  = local.token
        folder                 = var.folder_id
        group                  = local.group
        pod_cidr               = var.pod_cidr
        pod_gateway            = local.pod_gateway
        svc_cidr               = var.svc_cidr
        cluster_dns            = local.cluster_dns
        private_key            = tls_private_key.pk.private_key_pem
        public_key             = tls_private_key.pk.public_key_openssh
      })
    }

    network_settings {
      type = "STANDARD"
    }

    scheduling_policy {
      preemptible = var.preemptible
    }
  }

  allocation_policy {
    zones = var.zones
  }

  scale_policy {
    fixed_scale {
      size = var.size
    }
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 1
  }
}
