{
    "policyRule": {
      "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Network/virtualNetworks"
          },
          {
            "anyOf": [
              {
                "field": "tags['Environment']",
                "exists": "false"
              },
              {
                "field": "tags['Owner']",
                "exists": "false"
              },
              {
                "field": "tags['CostCenter']",
                "exists": "false"
              }
            ]
          }
        ]
      },
      "then": {
        "effect": "deny"
      }
    }
  }