#!/bin/bash
# Daily Network Health Check

# Check for networks without NSGs
echo "=== Networks without NSGs ==="
az network vnet list --query "[?!subnets[0].networkSecurityGroup].{Name:name, ResourceGroup:resourceGroup}" --output table

# Check for unused networks
echo "=== Potentially Unused Networks ==="
az network vnet list --query "[?!subnets[0].ipConfigurations].{Name:name, ResourceGroup:resourceGroup, Subnets:length(subnets)}" --output table

# Check peering status
echo "=== Peering Status ==="
az network vnet peering list --resource-group hub-network-rg --vnet-name hub-vnet-001 --query "[].{Name:name, Status:peeringState, RemoteVNet:remoteVirtualNetwork.id}" --output table

# Check for networks with overlapping address spaces
echo "=== Address Space Report ==="
az network vnet list --query "[].{Name:name, AddressSpace:addressSpace.addressPrefixes[0]}" --output table