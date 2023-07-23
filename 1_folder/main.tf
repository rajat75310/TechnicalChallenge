provider "azurerm" {
  features {}
}

# Create Resource Group
resource "azurerm_resource_group" "example_rg" {
  name     = "example-resource-group"
  location =  var.location
}

# Create Virtual Network
resource "azurerm_virtual_network" "example_vnet" {
  name                = "example-vnet"
  location            = azurerm_resource_group.example_rg.location
  resource_group_name = azurerm_resource_group.example_rg.name
  address_space       = ["10.0.0.0/16"]
}

# Create Subnets
resource "azurerm_subnet" "frontend_subnet" {
  name                 = "frontend-subnet"
  resource_group_name  = azurerm_resource_group.example_rg.name
  virtual_network_name = azurerm_virtual_network.example_vnet.name
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_subnet" "middleware_subnet" {
  name                 = "middleware-subnet"
  resource_group_name  = azurerm_resource_group.example_rg.name
  virtual_network_name = azurerm_virtual_network.example_vnet.name
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_subnet" "database_subnet" {
  name                 = "database-subnet"
  resource_group_name  = azurerm_resource_group.example_rg.name
  virtual_network_name = azurerm_virtual_network.example_vnet.name
  address_prefix       = "10.0.3.0/24"
}

# Create Network Interface for Frontend
resource "azurerm_network_interface" "frontend_nic" {
  name                = "frontend-nic"
  location            = azurerm_resource_group.example_rg.location
  resource_group_name = azurerm_resource_group.example_rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.frontend_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create Network Interface for Middleware
resource "azurerm_network_interface" "middleware_nic" {
  name                = "middleware-nic"
  location            = azurerm_resource_group.example_rg.location
  resource_group_name = azurerm_resource_group.example_rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.middleware_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create Network Interface for Database
resource "azurerm_network_interface" "database_nic" {
  name                = "database-nic"
  location            = azurerm_resource_group.example_rg.location
  resource_group_name = azurerm_resource_group.example_rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.database_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Call frontend module
module "frontend" {
  source = "./frontend"
  vm_name             = "frontend-vm"
  location            = azurerm_resource_group.example_rg.location
  resource_group_name = azurerm_resource_group.example_rg.name
  vm_size             = "Standard_DS1_v2"
  network_interface_id = azurerm_network_interface.frontend_nic.id
}

# Call middleware module
module "middleware" {
  source = "./frontend"

  vm_name             = "middleware-vm"
  location            = azurerm_resource_group.example_rg.location
  resource_group_name = azurerm_resource_group.example_rg.name
  vm_size             = "Standard_DS1_v2"
  network_interface_id = azurerm_network_interface.middleware_nic.id
}

# Call database module
module "database" {
  source = "./frontend"

  vm_name             = "database-vm"
  location            = azurerm_resource_group.example_rg.location
  resource_group_name = azurerm_resource_group.example_rg.name
  vm_size             = "Standard_DS1_v2"
  network_interface_id = azurerm_network_interface.database_nic.id
}