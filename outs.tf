output "group" {
  value = yandex_compute_instance_group.masters
}

output "bootstrap_token" {
  value = local.token
}

output "certificate_key" {
  value = local.certkey
}

output "pod_cidr" {
  value = var.pod_cidr
}

output "pod_gateway" {
  value = local.pod_gateway
}

output "svc_cidr" {
  value = var.svc_cidr
}

output "cluster_dns" {
  value = local.cluster_dns
}

output "name" {
  value = var.name
}

output "kubernetes_version" {
  value = var.kubernetes_version
}

output "control_plane_endpoint" {
  value = var.control_plane_endpoint
}

output "ssk_key" {
  value = tls_private_key.pk
}
