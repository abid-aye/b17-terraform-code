resource"azurerm_linux_virtual_machine" "frontend_virtual_machine" {
  
  name                = var.frontend_vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.virtual_machine_size

  admin_username      = data.azurerm_key_vault_secret.admin_username.value
  admin_password      = data.azurerm_key_vault_secret.admin_password.value # Ensure to use a secure method for handling passwords
 
  network_interface_ids= [
    data.azurerm_network_interface.frontend_nic.id]

  disable_password_authentication = "false"
  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  
  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}

data "azurerm_network_interface" "frontend_nic" {
  name                = var.frontend_nic_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault" "key_vault" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secret" "admin_password" {
  name         = "admin-password"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "admin_username" {
  name         = "admin-username"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}