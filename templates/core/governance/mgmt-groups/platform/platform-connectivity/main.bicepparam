using './main.bicep'

// General Parameters
param parLocations = [
  '{{primary_location}}'
  '{{secondary_location}}'
]
param parEnableTelemetry = true

param platformConnectivityConfig = {
  createOrUpdateManagementGroup: true
  managementGroupName: '{{management_group_id_prefix}}{{management_group_connectivity_id||connectivity}}{{management_group_id_postfix}}'
  managementGroupParentId: '{{management_group_id_prefix}}{{management_group_platform_id||platform}}{{management_group_id_postfix}}'
  managementGroupIntermediateRootName: '{{management_group_id_prefix}}{{management_group_int_root_id||alz}}{{management_group_id_postfix}}'
  managementGroupDisplayName: '{{management_group_name_prefix}}{{management_group_connectivity_name||Connectivity}}{{management_group_name_postfix}}'
  managementGroupDoNotEnforcePolicyAssignments: [
    'Enable-DDoS-VNET'
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
// Enable-DDoS-VNET is omitted: no DDoS plan or connectivity subscription is being deployed.
param parPolicyAssignmentParameterOverrides = {
}
