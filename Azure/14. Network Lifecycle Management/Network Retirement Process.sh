#!/bin/bash
# Network Retirement Script

VNET_NAME="$1"
RESOURCE_GROUP="$2"

echo "Starting retirement process for VNet: $VNET_NAME"

# 1. Check for dependencies
echo "Checking for dependencies..."
DEPENDENCIES=$(az network vnet show --name $VNET_NAME --resource-group $RESOURCE_GROUP --query "subnets[].ipConfigurations[].id" --output tsv)

if [ ! -z "$DEPENDENCIES" ]; then
    echo "❌ VNet has dependencies. Cannot retire."
    echo "Dependencies: $DEPENDENCIES"
    exit 1
fi

# 2. Remove peerings
echo "Removing peerings..."
az network vnet peering list --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --query "[].name" --output tsv | while read PEERING; do
    az network vnet peering delete --name $PEERING --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME
done

# 3. Update inventory
echo "Updating inventory..."
echo "$(date): Retired VNet $VNET_NAME from $RESOURCE_GROUP" >> network-retirement-log.txt

# 4. Delete VNet
echo "Deleting VNet..."
az network vnet delete --name $VNET_NAME --resource-group $RESOURCE_GROUP

echo "✅ VNet retirement completed"