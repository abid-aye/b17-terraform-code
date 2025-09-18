data "azurerm_subnet" "frontend_subnet" {
  name                 = var.frontend_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_subnet" "backend_subnet" {
  name                 = var.backend_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_public_ip" "frontend_public_ip" {
  name                = var.frontend_public_ip_name
  resource_group_name = var.resource_group_name
}

data "azurerm_public_ip" "backend_public_ip" {
  name                = var.backend_public_ip_name
  resource_group_name = var.resource_group_name
}


resource "azurerm_network_interface" "frontend_nic" {
  name                = var.frontend_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.frontend_subnet.id
    public_ip_address_id = data.azurerm_public_ip.frontend_public_ip.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_network_interface" "backend_nic" {
  name                = var.backend_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.backend_subnet.id
    public_ip_address_id = data.azurerm_public_ip.backend_public_ip.id
    private_ip_address_allocation = "Dynamic"
  }
}