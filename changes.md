# Changes from Default Accelerator Configuration

## Summary

These changes configure the ALZ Bicep Accelerator to deploy **management groups and policies only**, pointing at an existing Log Analytics workspace, with all policies set to DoNotEnforce. No networking resources, no logging resources, and no subscription placements are deployed.

---

## `examples/platform-landing-zone.yaml`

- Renamed Corp landing zone: ID `corp` → `internal`, display name `Corp` → `Internal`
- Renamed Online landing zone: ID `online` → `external`, display name `Online` → `External`
- Set `network_type` to `none` to skip all networking deployments (hub networking and Virtual WAN)

---

## `examples/bootstrap/inputs-azure-devops.yaml`
## `examples/bootstrap/inputs-github.yaml`
## `examples/bootstrap/inputs-local.yaml`

- Set `subscription_ids.management` to `ba9523fd-7e33-43fd-9f88-8c1ed1dd2234` (the subscription containing the existing Log Analytics workspace)
- Set `subscription_ids.identity`, `subscription_ids.connectivity`, and `subscription_ids.security` to empty strings — these subscriptions are not being used in this deployment

---

## `templates/core/governance/mgmt-groups/int-root/main.bicepparam`

- Populated `managementGroupDoNotEnforcePolicyAssignments` with all 17 policy assignments assigned at the intermediate root management group:
  `Audit-ResourceRGLocation`, `Audit-TrustedLaunch`, `Audit-UnusedResources`, `Audit-ZoneResiliency`, `Deny-Classic-Resources`, `Deny-UnmanagedDisk`, `Deploy-ASC-Monitoring`, `Deploy-AzActivity-Log`, `Deploy-Diag-LogsCat`, `Deploy-MCSB2-Monitoring`, `Deploy-MDEndpoints`, `Deploy-MDEndpointsAMA`, `Deploy-MDFC-Config-H224`, `Deploy-MDFC-OssDb`, `Deploy-MDFC-SqlAtp`, `Deploy-SvcHealth-BuiltIn`, `Enforce-ACSB`
- Updated all Log Analytics workspace references in `parPolicyAssignmentParameterOverrides` to point to the existing workspace:
  `/subscriptions/ba9523fd-7e33-43fd-9f88-8c1ed1dd2234/resourceGroups/dm-logicapp-rg/providers/Microsoft.OperationalInsights/workspaces/DM-Log-analytics`
  - Affects: `Deploy-MDFC-Config-H224` (`logAnalytics`), `Deploy-AzActivity-Log` (`logAnalytics`), `Deploy-Diag-LogsCat` (`logAnalytics`), `Deploy-AzSqlDb-Auditing` (`logAnalyticsWorkspaceResourceId`)

---

## `templates/core/governance/mgmt-groups/platform/main.bicepparam`

- Populated `managementGroupDoNotEnforcePolicyAssignments` with all 40 policy assignments assigned at the platform management group
- Updated `Deploy-MDFC-DefSQL-AMA` → `userWorkspaceResourceId` to point to the existing Log Analytics workspace

---

## `templates/core/governance/mgmt-groups/platform/platform-connectivity/main.bicepparam`

- Populated `managementGroupDoNotEnforcePolicyAssignments`: `['Enable-DDoS-VNET']`
- Cleared `subscriptionsToPlaceInManagementGroup` to `[]` (no connectivity subscription)
- Removed the `Enable-DDoS-VNET` policy parameter override — it referenced a DDoS protection plan in the connectivity subscription which is not being deployed

---

## `templates/core/governance/mgmt-groups/platform/platform-identity/main.bicepparam`

- Populated `managementGroupDoNotEnforcePolicyAssignments`: `['Deny-MgmtPorts-Internet', 'Deny-Public-IP', 'Deny-Subnet-Without-Nsg', 'Deploy-VM-Backup']`
- Cleared `subscriptionsToPlaceInManagementGroup` to `[]` (no identity subscription)

---

## `templates/core/governance/mgmt-groups/platform/platform-management/main.bicepparam`

- Cleared `subscriptionsToPlaceInManagementGroup` to `[]` (management subscription is used for pipeline authentication only, not for subscription placement in this MG)

---

## `templates/core/governance/mgmt-groups/platform/platform-security/main.bicepparam`

- Cleared `subscriptionsToPlaceInManagementGroup` to `[]` (no security subscription)

---

## `templates/core/governance/mgmt-groups/landingzones/main.bicepparam`

- Populated `managementGroupDoNotEnforcePolicyAssignments` with all 53 policy assignments assigned at the landing zones management group
- Removed the `Enable-DDoS-VNET` policy parameter override — it referenced a DDoS protection plan in the connectivity subscription which is not being deployed
- Updated `Deploy-AzSqlDb-Auditing` → `logAnalyticsWorkspaceId` and `Deploy-MDFC-DefSQL-AMA` → `userWorkspaceResourceId` to point to the existing Log Analytics workspace

---

## `templates/core/governance/mgmt-groups/landingzones/landingzones-corp/main.bicepparam`

- Populated `managementGroupDoNotEnforcePolicyAssignments`: `['Audit-PeDnsZones', 'Deny-HybridNetworking', 'Deny-Public-Endpoints', 'Deny-Public-IP-On-NIC', 'Deploy-Private-DNS-Zones']`
- Removed the entire `Deploy-Private-DNS-Zones` policy parameter override block — it referenced Private DNS zones and an `additionalSubscriptionIDsToAssignRbacTo` entry using the connectivity subscription ID. With no connectivity subscription, this caused an ARM error (`identity/` — empty subscription ID producing an invalid resource name segment)

---

## `templates/core/governance/mgmt-groups/sandbox/main.bicepparam`

- Populated `managementGroupDoNotEnforcePolicyAssignments`: `['Enforce-ALZ-Sandbox']`

---

## `templates/core/governance/mgmt-groups/decommissioned/main.bicepparam`

- Populated `managementGroupDoNotEnforcePolicyAssignments`: `['Enforce-ALZ-Decomm']`

---

## Resources intentionally NOT deployed

The following templates exist in the repository but are not configured for deployment in this setup:

| Template | Reason skipped |
|---|---|
| `templates/core/logging/` | Customer has an existing Log Analytics workspace; a new one is not required |
| `templates/networking/hubnetworking/` | No hub networking required (`network_type: none`) |
| `templates/networking/virtualwan/` | No Virtual WAN required (`network_type: none`) |

The ALZ PowerShell module automatically skips the logging and networking deployments based on the `network_type: none` setting and the absence of active subscription IDs for connectivity.
