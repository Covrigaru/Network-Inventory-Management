


# Test network connectivity between regions
az network watcher test-connectivity \
  --resource-group prod-network-rg \
  --source-resource prod-vm-eastus \
  --dest-resource prod-vm-westus \
  --dest-port 443