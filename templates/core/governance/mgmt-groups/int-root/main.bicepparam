using './main.bicep'

// General Parameters
param parLocations = [
  '{{primary_location}}'
  '{{secondary_location}}'
]
param parEnableTelemetry = true

param intRootConfig = {
  createOrUpdateManagementGroup: true
  managementGroupName: '{{management_group_id_prefix}}{{management_group_int_root_id||alz}}{{management_group_id_postfix}}'
  managementGroupParentId: '{{root_parent_management_group_id}}'
  managementGroupDisplayName: '{{management_group_name_prefix}}{{management_group_int_root_name||Azure Landing Zones}}{{management_group_name_postfix}}'
  managementGroupDoNotEnforcePolicyAssignments: [
    'Audit-ResourceRGLocation'
    'Audit-TrustedLaunch'
    'Audit-UnusedResources'
    'Audit-ZoneResiliency'
    'Deny-Classic-Resources'
    'Deny-UnmanagedDisk'
    'Deploy-ASC-Monitoring'
    'Deploy-AzActivity-Log'
    'Deploy-Diag-LogsCat'
    'Deploy-MCSB2-Monitoring'
    'Deploy-MDEndpoints'
    'Deploy-MDEndpointsAMA'
    'Deploy-MDFC-Config-H224'
    'Deploy-MDFC-OssDb'
    'Deploy-MDFC-SqlAtp'
    'Deploy-SvcHealth-BuiltIn'
    'Enforce-ACSB'
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
  'Deploy-MDFC-Config-H224': {
    parameters: {
      logAnalytics: {
        value: '/subscriptions/ba9523fd-7e33-43fd-9f88-8c1ed1dd2234/resourceGroups/dm-logicapp-rg/providers/Microsoft.OperationalInsights/workspaces/DM-Log-analytics'
      }
      emailSecurityContact: {
        value: 'security@yourcompany.com'
      }
      ascExportResourceGroupName: {
        value: 'rg-alz-asc-${parLocations[0]}'
      }
      ascExportResourceGroupLocation: {
        value: parLocations[0]
      }
    }
  }
  'Deploy-AzActivity-Log': {
    parameters: {
      logAnalytics: {
        value: '/subscriptions/ba9523fd-7e33-43fd-9f88-8c1ed1dd2234/resourceGroups/dm-logicapp-rg/providers/Microsoft.OperationalInsights/workspaces/DM-Log-analytics'
      }
      logsEnabled: {
        value: 'True'
      }
    }
  }
  'Deploy-Diag-LogsCat': {
    parameters: {
      logAnalytics: {
        value: '/subscriptions/ba9523fd-7e33-43fd-9f88-8c1ed1dd2234/resourceGroups/dm-logicapp-rg/providers/Microsoft.OperationalInsights/workspaces/DM-Log-analytics'
      }
    }
  }
  'Deploy-SvcHealth-BuiltIn': {
    parameters: {
      resourceGroupLocation: {
        value: parLocations[0]
      }
      actionGroupResources: {
        value: {
          actionGroupEmail: ['triage@yourcompany.com']
          eventHubResourceId: []
          functionResourceId: ''
          functionTriggerUrl: ''
          logicappCallbackUrl: ''
          logicappResourceId: ''
          webhookServiceUri: []
        }
      }
    }
  }
  'Deploy-AzSqlDb-Auditing': {
    parameters: {
      logAnalyticsWorkspaceResourceId: {
        value: '/subscriptions/ba9523fd-7e33-43fd-9f88-8c1ed1dd2234/resourceGroups/dm-logicapp-rg/providers/Microsoft.OperationalInsights/workspaces/DM-Log-analytics'
      }
    }
  }
}
