#!/bin/bash

# Create connection monitor for critical network paths
az network watcher connection-monitor create \
  --resource-group NetworkWatcherRG \
  --name prod-network-monitor \
  --location eastus \
  --source-resource prod-web-vm-001 \
  --dest-resource prod-db-vm-001 \
  --dest-port 1433