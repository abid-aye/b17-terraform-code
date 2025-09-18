module "resource_group" {
  source                  = "../module/azuerrm_resource_group"
  resource_group_name     = "todoapp-rg"
  resource_group_location = "East US"
}

module "virtual_network" {
  depends_on = [
    module.resource_group
  ]

  source                   = "../module/azurerm_virtual_network"
  virtual_network_name     = "todoapp-vnet"
  virtual_network_location = "East US"
  resource_group_name      = "todoapp-rg"
  address_space            = ["10.0.0.0/16"]
}

module "frontend_subnet" {
  depends_on = [
    module.virtual_network
  ]

  source               = "../module/azurerm_subnet"
  subnet_name          = "frontend-subnet"
  resource_group_name  = "todoapp-rg"
  virtual_network_name = "todoapp-vnet"
  address_prefixes     = ["10.0.1.0/24"]
}

module "backend_subnet" {
  depends_on = [
    module.virtual_network
  ]

  source               = "../module/azurerm_subnet"
  subnet_name          = "backend-subnet"
  resource_group_name  = "todoapp-rg"
  virtual_network_name = "todoapp-vnet"
  address_prefixes     = ["10.0.2.0/24"]
}

module "frontend_public_ip" {
  depends_on = [
    module.resource_group
  ]
  source              = "../module/azurerm_public_ip"
  public_ip_name      = "frontend-public-ip"
  resource_group_name = "todoapp-rg"
  location            = "East US"
  allocation_method   = "Static"
}

module "backend_public_ip" {
  depends_on = [
    module.resource_group
  ]
  source              = "../module/azurerm_public_ip"
  public_ip_name      = "backend-public-ip"
  resource_group_name = "todoapp-rg"
  location            = "East US"
  allocation_method   = "Static"
}

module "network_interfaces" {
  depends_on = [
    module.frontend_subnet,
    module.backend_subnet,
    module.frontend_public_ip,
    module.backend_public_ip
  ]

  source               = "../module/azurerm_network_interface"
  location             = "East US"
  resource_group_name  = "todoapp-rg"
  virtual_network_name = "todoapp-vnet"

  frontend_nic_name       = "frontend-nic"
  frontend_subnet_name    = "frontend-subnet"
  frontend_public_ip_name = "frontend-public-ip"

  backend_nic_name       = "backend-nic"
  backend_subnet_name    = "backend-subnet"
  backend_public_ip_name = "backend-public-ip"
}



module "frontend_vm" {
  depends_on = [module.network_interfaces, module.key_vault]

  source               = "../module/azurerm_frontend_virtual_machine"
  frontend_vm_name     = "frontendtodoapp-vm"
  resource_group_name  = "todoapp-rg"
  location             = "East US"
  virtual_machine_size = "Standard_B1s"
  # Fetch username from Key Vault
  # Ensure to use a secure method for handling passwords
  image_publisher   = "Canonical"
  image_offer       = "0001-com-ubuntu-server-jammy"
  image_sku         = "22_04-lts"
  image_version     = "latest"
  frontend_nic_name = "frontend-nic"
  key_vault_name    = "todoapp-key-vault"



}
module "backend_vm" {
  depends_on = [module.network_interfaces, module.key_vault]

  source               = "../module/azurerm_backend_virtual_machine"
  backend_vm_name      = "backendtodapp-vm"
  resource_group_name  = "todoapp-rg"
  location             = "East US"
  virtual_machine_size = "Standard_B1s"
  # Fetch username from Key Vault
  # Ensure to use a secure method for handling passwords
  image_publisher  = "Canonical"
  image_offer      = "0001-com-ubuntu-server-jammy"
  image_sku        = "22_04-lts"
  image_version    = "latest"
  backend_nic_name = "backend-nic"
  key_vault_name   = "todoapp-key-vault"


}

module "mssql_server" {
  depends_on = [
    module.resource_group
  ]

  source              = "../module/azurerm_mssql_server"
  mssql_server_name   = "todapp-sql-server3"
  resource_group_name = "todoapp-rg" # yeh eastus me hai
  mssql_location      = "centralus"  # Changed to avoid provisioning restriction
  # Note: The location of the SQL Server must be different from the resource group location due to Azure's restrictions.
  administrator_login          = "adminuser"
  administrator_login_password = "P@ssw0rd123!" # Ensure to use a secure method for handling passwords

}

module "mssql_database" {
  depends_on = [
    module.mssql_server
  ]

  source              = "../module/azurerm_mssql_database"
  mssql_database      = "todoappdb3"
  mssql_server_name   = "todapp-sql-server3"
  resource_group_name = "todoapp-rg"
}

module "key_vault" {
  depends_on = [
    module.resource_group
  ]

  source              = "../module/azurerm_key_vault"
  key_vault_name      = "todoapp-key-vault"
  resource_group_name = "todoapp-rg"
  key_vault_location  = "East US"
  admin_username      = "userershad"
  admin_password      = "user@ershad1"
}