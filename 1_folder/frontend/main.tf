variable "vm_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "vm_size" {}
variable "network_interface_id" {}

# Frontend module Terraform configuration
resource "azurerm_virtual_machine" "frovmntend_vm" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  vm_size             = var.vm_size

  network_interface_ids = [var.network_interface_id]

  # Additional configurations for the frontend VM (e.g., OS image, etc.)
}

output "frontend_vm_id" {
  description = "The ID of the frontend virtual machine."
  value       = azurerm_virtual_machine.frontend_vm.id
}

output "frontend_vm_ip" {
  description = "The private IP address of the frontend virtual machine."
  value       = azurerm_virtual_machine.frontend_vm.private_ip_address
}
