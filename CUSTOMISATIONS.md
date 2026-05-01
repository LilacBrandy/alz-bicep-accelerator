# ALZ Bicep Accelerator - Deployment Customisations

This document describes the customisations made to the default ALZ Bicep Accelerator configuration for this deployment.

---

## 1. Management Group Renaming

Two of the default child management groups under **Landing Zones** have been renamed to better reflect the organisation's workload segmentation.

### Changes

| Default ID | Default Display Name | Custom ID | Custom Display Name |
|---|---|---|---|
| `corp` | Corp | `internal` | Internal |
| `online` | Online | `external` | External |

### Where to set these

In [examples/platform-landing-zone.yaml](examples/platform-landing-zone.yaml), update the following values:

```yaml
management_group_corp_id: "internal"
management_group_corp_name: "Internal"

management_group_online_id: "external"
management_group_online_name: "External"
```

The `main.bicepparam` files for these management groups use the `{{management_group_corp_id}}`, `{{management_group_corp_name}}`, `{{management_group_online_id}}` and `{{management_group_online_name}}` tokens, which are automatically replaced with the values above during the bootstrap process. No direct edits to the bicepparam files are required.

Relevant bicepparam files:
- [templates/core/governance/mgmt-groups/landingzones/landingzones-corp/main.bicepparam](templates/core/governance/mgmt-groups/landingzones/landingzones-corp/main.bicepparam)
- [templates/core/governance/mgmt-groups/landingzones/landingzones-online/main.bicepparam](templates/core/governance/mgmt-groups/landingzones/landingzones-online/main.bicepparam)

---

## 2. Networking — Not Deployed

Networking resources (hub VNet, Azure Firewall, Bastion, VPN/ExpressRoute Gateways, DDoS Protection Plan, Private DNS Zones) are **not deployed** as part of this deployment.

### Where to set this

In [examples/platform-landing-zone.yaml](examples/platform-landing-zone.yaml):

```yaml
network_type: "none"
```

Setting `network_type` to `none` means the networking module (`templates/networking/hubnetworking/` or `templates/networking/virtualwan/`) is skipped entirely. No networking resources or resource groups are created.

> **Note:** If networking is required in future, set `network_type` to `hubNetworking` or `vwanConnectivity` and configure the corresponding `main.bicepparam` before re-running the deployment.

---

## 3. Microsoft Defender for Cloud — TBD

> **To be completed.** The specific Defender policy assignments to deny/exclude are still being reviewed. This section will document:
> - Which Defender-related policy assignments are being excluded or denied
> - Which management groups they apply to
> - How to set `managementGroupExcludedPolicyAssignments` or `managementGroupDoNotEnforcePolicyAssignments` in the relevant `main.bicepparam` files

---

## Summary of Files Modified

| File | Change |
|---|---|
| [examples/platform-landing-zone.yaml](examples/platform-landing-zone.yaml) | `management_group_corp_id/name`, `management_group_online_id/name`, `network_type` |
