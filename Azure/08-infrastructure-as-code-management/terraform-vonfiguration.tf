# terraform/networks.tf
resource "azurerm_virtual_network" "networks" {
  for_each = var.networks
  
  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group
  address_space       = each.value.address_space
  
  tags = merge(var.common_tags, {
    Environment = each.value.environment
    Owner      = each.value.owner
    Function   = each.value.function
  })
}

# Variables file
variable "networks" {
  type = map(object({
    location         = string
    resource_group   = string
    address_space    = list(string)
    environment      = string
    owner           = string
    function        = string
  }))
}