#!/bin/bash
# Azure Network Discovery Script

# Get all subscriptions
subscriptions=$(az account list --query "[].id" --output tsv)

echo "VNetName,ResourceGroup,Location,AddressSpace,SubnetCount,Environment,Owner,LastUpdated" > network-inventory.csv

for subscription in $subscriptions; do
    echo "Processing subscription: $subscription"
    az account set --subscription $subscription
    
    # Get all VNets
    vnets=$(az network vnet list --query "[].{name:name,resourceGroup:resourceGroup,location:location,addressSpace:addressSpace.addressPrefixes[0],subnets:subnets[].name,tags:tags}" --output json)
    
    echo "$vnets" | jq -r '.[] | [.name, .resourceGroup, .location, .addressSpace, (.subnets | length), .tags.Environment // "Not Set", .tags.Owner // "Not Set", now | strftime("%Y-%m-%d")] | @csv' >> network-inventory.csv
done

echo "Network inventory saved to network-inventory.csv"