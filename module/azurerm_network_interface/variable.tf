variable "frontend_nic_name" {
  description = "The name of the network interface to create."
  type        = string
}

variable "backend_nic_name" {
  description = "The name of the backend network interface to create."
  type        = string
}

variable "location" {
  description = "The Azure location where the network interface will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the network interface will be created."
  type        = string
}

variable "frontend_subnet_name" {
  description = "The name of the frontend subnet."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network where the subnet is located."
  type        = string
}

variable "backend_subnet_name" {
  description = "The name of the backend subnet."
  type        = string
}

variable "frontend_public_ip_name" {
  description = "The name of the public IP address for the frontend."
  type        = string
}

variable "backend_public_ip_name" {
  description = "The name of the public IP address for the backend."
  type        = string
}
