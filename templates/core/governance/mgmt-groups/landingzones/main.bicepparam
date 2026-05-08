using './main.bicep'

// General Parameters
param parLocations = [
  '{{primary_location}}'
  '{{secondary_location}}'
]
param parEnableTelemetry = true

param landingZonesConfig = {
  createOrUpdateManagementGroup: true
  managementGroupName: '{{management_group_id_prefix}}{{management_group_landing_zones_id||landingzones}}{{management_group_id_postfix}}'
  managementGroupParentId: '{{management_group_id_prefix}}{{management_group_int_root_id||alz}}{{management_group_id_postfix}}'
  managementGroupIntermediateRootName: '{{management_group_id_prefix}}{{management_group_int_root_id||alz}}{{management_group_id_postfix}}'
  managementGroupDisplayName: '{{management_group_name_prefix}}{{management_group_landing_zones_name||Landing Zones}}{{management_group_name_postfix}}'
  managementGroupDoNotEnforcePolicyAssignments: [
    'Audit-AppGW-WAF'
    'Deny-IP-forwarding'
    'Deny-MgmtPorts-Internet'
    'Deny-Priv-Esc-AKS'
    'Deny-Privileged-AKS'
    'Deny-Storage-http'
    'Deny-Subnet-Without-Nsg'
    'Deploy-AzSqlDb-Auditing'
    'Deploy-GuestAttest'
    'Deploy-MDFC-DefSQL-AMA'
    'Deploy-SQL-TDE'
    'Deploy-SQL-Threat'
    'Deploy-VM-Backup'
    'Deploy-VM-ChangeTrack'
    'Deploy-VM-Monitoring'
    'Deploy-vmArc-ChangeTrack'
    'Deploy-vmHybr-Monitoring'
    'Deploy-VMSS-ChangeTrack'
    'Deploy-VMSS-Monitoring'
    'Enable-AUM-CheckUpdates'
    'Enable-DDoS-VNET'
    'Enforce-AKS-HTTPS'
    'Enforce-ASR'
    'Enforce-Encrypt-CMK0'
    'Enforce-GR-APIM0'
    'Enforce-GR-AppServices0'
    'Enforce-GR-Automation0'
    'Enforce-GR-BotService0'
    'Enforce-GR-CogServ0'
    'Enforce-GR-Compute0'
    'Enforce-GR-ContApps0'
    'Enforce-GR-ContInst0'
    'Enforce-GR-ContReg0'
    'Enforce-GR-CosmosDb0'
    'Enforce-GR-DataExpl0'
    'Enforce-GR-DataFactory0'
    'Enforce-GR-EventGrid0'
    'Enforce-GR-EventHub0'
    'Enforce-GR-KeyVault'
    'Enforce-GR-KeyVaultSup0'
    'Enforce-GR-Kubernetes0'
    'Enforce-GR-MachLearn0'
    'Enforce-GR-MySQL0'
    'Enforce-GR-Network0'
    'Enforce-GR-OpenAI0'
    'Enforce-GR-PostgreSQL0'
    'Enforce-GR-ServiceBus0'
    'Enforce-GR-SQL0'
    'Enforce-GR-Storage0'
    'Enforce-GR-Synapse0'
    'Enforce-GR-VirtualDesk0'
    'Enforce-Subnet-Private'
    'Enforce-TLS-SSL-Q225'
  ]
  managementGroupExcludedPolicyAssignments: []
  customerRbacRoleDefs: []
  customerRbacRoleAssignments: []
  customerPolicyDefs: []
  customerPolicySetDefs: []
  customerPolicyAssignments: []
  subscriptionsToPlaceInManagementGroup: []
  waitForConsistencyCounterBeforeCustomPolicyDefinitions: 10
  waitForConsistencyCounterBeforeCustomPolicySetDefinitions: 10
  waitForConsistencyCounterBeforeCustomRoleDefinitions: 10
  waitForConsistencyCounterBeforePolicyAssignments: 40
  waitForConsistencyCounterBeforeRoleAssignments: 40
  waitForConsistencyCounterBeforeSubPlacement: 10
}

// Only specify the parameters you want to override - others will use defaults from JSON files
param parPolicyAssignmentParameterOverrides = {
  'Enable-DDoS-VNET': {
    parameters: {
      ddosPlan: {
        value: '/subscriptions/{{connectivity_subscription_id}}/resourceGroups/{{resource_group_hub_networking_name_prefix||rg-alz-conn}}-${parLocations[0]}/providers/Microsoft.Network/ddosProtectionPlans/ddos-alz-${parLocations[0]}'
      }
    }
  }
  'Deploy-AzSqlDb-Auditing': {
    parameters: {
      logAnalyticsWorkspaceId: {
        value: '/subscriptions/ba9523fd-7e33-43fd-9f88-8c1ed1dd2234/resourceGroups/dm-logicapp-rg/providers/Microsoft.OperationalInsights/workspaces/DM-Log-analytics'
      }
    }
  }
  'Deploy-vmArc-ChangeTrack': {
    parameters: {
      dcrResourceId: {
        value: '/subscriptions/{{management_subscription_id}}/resourceGroups/{{resource_group_logging_name_prefix||rg-alz-logging}}-${parLocations[0]}/providers/Microsoft.Insights/dataCollectionRules/dcr-ct-alz-${parLocations[0]}'
      }
    }
  }
  'Deploy-VM-ChangeTrack': {
    parameters: {
      dcrResourceId: {
        value: '/subscriptions/{{management_subscription_id}}/resourceGroups/{{resource_group_logging_name_prefix||rg-alz-logging}}-${parLocations[0]}/providers/Microsoft.Insights/dataCollectionRules/dcr-ct-alz-${parLocations[0]}'
      }
      userAssignedIdentityResourceId: {
        value: '/subscriptions/{{management_subscription_id}}/resourceGroups/{{resource_group_logging_name_prefix||rg-alz-logging}}-${parLocations[0]}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-alz-${parLocations[0]}'
      }
    }
  }
  'Deploy-VMSS-ChangeTrack': {
    parameters: {
      dcrResourceId: {
        value: '/subscriptions/{{management_subscription_id}}/resourceGroups/{{resource_group_logging_name_prefix||rg-alz-logging}}-${parLocations[0]}/providers/Microsoft.Insights/dataCollectionRules/dcr-ct-alz-${parLocations[0]}'
      }
      userAssignedIdentityResourceId: {
        value: '/subscriptions/{{management_subscription_id}}/resourceGroups/{{resource_group_logging_name_prefix||rg-alz-logging}}-${parLocations[0]}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-alz-${parLocations[0]}'
      }
    }
  }
  'Deploy-vmHybr-Monitoring': {
    parameters: {
      dcrResourceId: {
        value: '/subscriptions/{{management_subscription_id}}/resourceGroups/{{resource_group_logging_name_prefix||rg-alz-logging}}-${parLocations[0]}/providers/Microsoft.Insights/dataCollectionRules/dcr-vmi-alz-${parLocations[0]}'
      }
    }
  }
  'Deploy-VM-Monitoring': {
    parameters: {
      dcrResourceId: {
        value: '/subscriptions/{{management_subscription_id}}/resourceGroups/{{resource_group_logging_name_prefix||rg-alz-logging}}-${parLocations[0]}/providers/Microsoft.Insights/dataCollectionRules/dcr-vmi-alz-${parLocations[0]}'
      }
      userAssignedIdentityResourceId: {
        value: '/subscriptions/{{management_subscription_id}}/resourceGroups/{{resource_group_logging_name_prefix||rg-alz-logging}}-${parLocations[0]}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-alz-${parLocations[0]}'
      }
    }
  }
  'Deploy-VMSS-Monitoring': {
    parameters: {
      dcrResourceId: {
        value: '/subscriptions/{{management_subscription_id}}/resourceGroups/{{resource_group_logging_name_prefix||rg-alz-logging}}-${parLocations[0]}/providers/Microsoft.Insights/dataCollectionRules/dcr-vmi-alz-${parLocations[0]}'
      }
      userAssignedIdentityResourceId: {
        value: '/subscriptions/{{management_subscription_id}}/resourceGroups/{{resource_group_logging_name_prefix||rg-alz-logging}}-${parLocations[0]}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-alz-${parLocations[0]}'
      }
    }
  }
  'Deploy-MDFC-DefSQL-AMA': {
    parameters: {
      userWorkspaceResourceId: {
        value: '/subscriptions/ba9523fd-7e33-43fd-9f88-8c1ed1dd2234/resourceGroups/dm-logicapp-rg/providers/Microsoft.OperationalInsights/workspaces/DM-Log-analytics'
      }
      dcrResourceId: {
        value: '/subscriptions/{{management_subscription_id}}/resourceGroups/{{resource_group_logging_name_prefix||rg-alz-logging}}-${parLocations[0]}/providers/Microsoft.Insights/dataCollectionRules/dcr-mdfcsql-alz-${parLocations[0]}'
      }
      userAssignedIdentityResourceId: {
        value: '/subscriptions/{{management_subscription_id}}/resourceGroups/{{resource_group_logging_name_prefix||rg-alz-logging}}-${parLocations[0]}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-alz-${parLocations[0]}'
      }
    }
  }
}
