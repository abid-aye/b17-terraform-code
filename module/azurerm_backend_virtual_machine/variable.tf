variable "location" {
  description = "The Azure location where the virtual machine will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the virtual machine will be created."
  type        = string

}



variable "backend_nic_name" {
  description = "The name of the backend network interface."
  type        = string
   
}



variable "backend_vm_name" {
  description = "The name of the backend virtual machine to create."
  type        = string
  
}

variable "virtual_machine_size" {
  description = "The size of the virtual machine."
  type        = string
  default     = "Standard_DS1_v2"
}
variable "image_publisher" {
  description = "The publisher of the virtual machine image."
  type        = string
  
}
variable "image_offer" {
  description = "The offer of the virtual machine image."
  type        = string
}
variable "image_sku" {
  description = "The SKU of the virtual machine image."
  type        = string
}
variable "image_version" {
  description = "The version of the virtual machine image."
  type        = string
  
}
variable "key_vault_name" {
  description = "The name of the Azure Key Vault."
  type        = string
}

