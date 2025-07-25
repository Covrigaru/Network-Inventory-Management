{
    "resources": [
      {
        "type": "Microsoft.Network/virtualNetworks",
        "apiVersion": "2021-02-01",
        "name": "[parameters('vnetName')]",
        "location": "[parameters('location')]",
        "tags": {
          "Environment": "[parameters('environment')]",
          "Owner": "[parameters('owner')]",
          "CostCenter": "[parameters('costCenter')]",
          "CreatedDate": "[utcNow('yyyy-MM-dd')]",
          "LastReviewed": "[utcNow('yyyy-MM-dd')]"
        }
      }
    ]
  }