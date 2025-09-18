variable "public_ip_name" {
  description = "The name of the public IP address to create."
  type        = string
}
variable "location" {
  description = "The Azure location where the public IP address will be created."
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group where the public IP address will be created."
  type        = string
}
variable "allocation_method" {
  description = "The allocation method for the public IP address. Can be 'Static' or 'Dynamic'."
  type        = string
  default     = "Static"
}
