variable "folder" {
  type        = string
  description = "Yandex Folder name where to deploy resoruces."
}

variable "prefix" {
  default     = ""
  description = "Prefix for resource names."
}

variable "zones" {
  type        = list(string)
  description = "List of Yandex Cloud zones where VMs can be placed."
}

variable "sa" {
  type        = string
  description = "ID of a service account used for control plane VMs."
}

variable "preemptible" {
  default     = true
  description = "Use preemptible VMs for control plane."
}

variable "image" {
  type        = string
  description = "Name of a LinuxKit based image build from github.com/yandexcloud/kubernetes."
}

variable "platform_id" {
  default     = "standard-v2"
  description = "Platform ID of control plane VMs."
}

variable "enable_serial_port" {
  defdefault  = false
  description = "Indicates whether to enable serial port for control plane VMs."
}

variable "size" {
  default     = 3
  description = "Number of control plane VMs."
}

variable "cores" {
  default     = 2
  description = "Number of cores used in control plane VMs."
}

variable "core_fraction" {
  default     = 20
  description = "CPU core fraction (%) allowed to use for control plane VMs."
}

variable "memory" {
  default     = 2
  description = "Memory size (GB) of control plane VMs."
}

variable "boot_disk_type" {
  default     = "network-ssd"
  description = "Boot disk type of control plane VMs."
}

variable "boot_disk_size" {
  default     = 1
  description = "Boot disk size of control plane VMs."
}

variable "data_disk_type" {
  default     = "network-ssd"
  description = "Data disk type of control plane VMs."
}

variable "data_disk_size" {
  default     = 10
  description = "Data disk size of control plance VMs."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs to attach control plane VMs to."
}

variable "ssh_keys" {
  type        = list(string)
  description = "Authorized keys for control plane VMs."
}

variable "control_plane_endpoint" {
  type        = string
  description = "Stable control plane endpoint, it's recommended to use DNS name of an API proxy."
}

variable "name" {
  type        = string
  description = "Cluser name."
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version."
}

variable "pod_cidr" {
  default     = "10.100.0.0/16"
  description = "Pod subnet CIDR."
}

variable "svc_cidr" {
  default     = "10.96.0.0/16"
  description = "Service subnet CIDR."
}

# variable "domain" {
#   type        = string
#   description = "Public domain name in AWS Route53."
# }

# variable "aws_region" {
#   type        = string
#   description = "AWS region used to assume role to access Route53."
# }

# variable "aws_role_arn" {
#   type        = string
#   description = "ARN of the AWS role to assume to access Route53."
# }

# variable "aws_access_key" {
#   type        = string
#   description = "AWS access key ID used to assume role to access Route53."
# }

# variable "aws_secret_key" {
#   type        = string
#   description = "AWS secret access key used to assume role to access Route53."
# }

# variable "eproxy_image" {
#   type        = string
#   description = "Name of image build from github.com/yandexcloud/eproxy, used for API proxy."
# }

# variable "eproxy_sa" {
#   type        = string
#   description = "ID of a service account used in API proxy VMs."
# }

# variable "eproxy_platform_id" {
#   default     = "standard-v2"
#   description = "Platform ID used for API proxy VMs."
# }

# variable "eproxy_cores" {
#   default     = 2
#   description = "Number of cores of API proxy VMs."
# }
