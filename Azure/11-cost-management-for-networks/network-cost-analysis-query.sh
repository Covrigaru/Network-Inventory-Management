#!/bin/bash
# Get network costs by resource group
az consumption usage list \
  --start-date "2024-01-01" \
  --end-date "2024-01-31" \
  --query "[?contains(instanceName, 'network') || contains(meterCategory, 'Network')]" \
  --output table