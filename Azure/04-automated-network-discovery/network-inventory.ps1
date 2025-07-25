# Azure Network Inventory Script
$subscriptions = Get-AzSubscription

$networkInventory = @()

foreach ($subscription in $subscriptions) {
    Set-AzContext -SubscriptionId $subscription.Id
    
    $vnets = Get-AzVirtualNetwork
    
    foreach ($vnet in $vnets) {
        $networkInfo = [PSCustomObject]@{
            SubscriptionName = $subscription.Name
            SubscriptionId = $subscription.Id
            VNetName = $vnet.Name
            ResourceGroup = $vnet.ResourceGroupName
            Location = $vnet.Location
            AddressSpace = ($vnet.AddressSpace.AddressPrefixes -join ", ")
            SubnetCount = $vnet.Subnets.Count
            Subnets = ($vnet.Subnets.Name -join ", ")
            PeeringCount = $vnet.VirtualNetworkPeerings.Count
            Peerings = ($vnet.VirtualNetworkPeerings.Name -join ", ")
            Tags = ($vnet.Tags.GetEnumerator() | ForEach-Object { "$($_.Key):$($_.Value)" }) -join "; "
            CreatedDate = $vnet.Tags["CreatedDate"]
            Owner = $vnet.Tags["Owner"]
            Environment = $vnet.Tags["Environment"]
            LastInventoried = Get-Date -Format "yyyy-MM-dd"
        }
        $networkInventory += $networkInfo
    }
}

# Export to CSV
$networkInventory | Export-Csv -Path "Azure-Network-Inventory-$(Get-Date -Format 'yyyy-MM-dd').csv" -NoTypeInformation

# Export to JSON for automation
$networkInventory | ConvertTo-Json | Out-File "Azure-Network-Inventory-$(Get-Date -Format 'yyyy-MM-dd').json"