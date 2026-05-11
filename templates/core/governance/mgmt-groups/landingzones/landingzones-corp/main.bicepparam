using './main.bicep'

// General Parameters
param parLocations = [
  '{{primary_location}}'
  '{{secondary_location}}'
]
param parEnableTelemetry = true

param landingZonesCorpConfig = {
  createOrUpdateManagementGroup: true
  managementGroupName: '{{management_group_id_prefix}}{{management_group_corp_id||corp}}{{management_group_id_postfix}}'
  managementGroupParentId: '{{management_group_id_prefix}}{{management_group_landing_zones_id||landingzones}}{{management_group_id_postfix}}'
  managementGroupIntermediateRootName: '{{management_group_id_prefix}}{{management_group_int_root_id||alz}}{{management_group_id_postfix}}'
  managementGroupDisplayName: '{{management_group_name_prefix}}{{management_group_corp_name||Corp}}{{management_group_name_postfix}}'
  managementGroupDoNotEnforcePolicyAssignments: [
    'Audit-PeDnsZones'
    'Deny-HybridNetworking'
    'Deny-Public-Endpoints'
    'Deny-Public-IP-On-NIC'
    'Deploy-Private-DNS-Zones'
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
// Deploy-Private-DNS-Zones is omitted: no connectivity subscription or DNS zones are being deployed.
param parPolicyAssignmentParameterOverrides = {
  // Audit-PeDnsZones Policy: Define which private DNS zone names to audit for compliance
  // This ensures private endpoints are using the correct DNS zones
  'Audit-PeDnsZones': {
    parameters: {
      privateLinkDnsZones: {
        value: [
          'privatelink.azurecr.io' // Azure Container Registry
          'privatelink.azurewebsites.net' // Azure App Service & Function Apps
          'privatelink.guestconfiguration.azure.com' // Azure Arc Guest Configuration
          'privatelink.his.arc.azure.com' // Azure Arc Hybrid Resource Provider
          'privatelink.dp.kubernetesconfiguration.azure.com' // Azure Arc Kubernetes Configuration
          'privatelink.siterecovery.windowsazure.com' // Azure Site Recovery
          'privatelink.azure-automation.net' // Azure Automation DSC Hybrid & Webhook
          'privatelink.batch.azure.com' // Azure Batch
          'privatelink.directline.botframework.com' // Azure Bot Service
          'privatelink.search.windows.net' // Azure Cognitive Search
          'privatelink.cognitiveservices.azure.com' // Azure Cognitive Services
          'privatelink.cassandra.cosmos.azure.com' // Azure Cosmos DB Cassandra
          'privatelink.gremlin.cosmos.azure.com' // Azure Cosmos DB Gremlin
          'privatelink.mongo.cosmos.azure.com' // Azure Cosmos DB MongoDB
          'privatelink.documents.azure.com' // Azure Cosmos DB SQL API
          'privatelink.table.cosmos.azure.com' // Azure Cosmos DB Table
          'privatelink.adf.azure.com' // Azure Data Factory Portal
          'privatelink.datafactory.azure.net' // Azure Data Factory
          'privatelink.azuredatabricks.net' // Azure Databricks
          'privatelink.eventgrid.azure.net' // Azure Event Grid (domains & topics)
          'privatelink.servicebus.windows.net' // Azure Event Hub & Service Bus
          'privatelink.afs.azure.net' // Azure Files
          'privatelink.azurehdinsight.net' // Azure HDInsight
          'privatelink.azureiotcentral.com' // Azure IoT Central
          'privatelink.api.adu.microsoft.com' // Azure IoT Device Update
          'privatelink.azure-devices.net' // Azure IoT Hubs
          'privatelink.azure-devices-provisioning.net' // Azure IoT Device Provisioning
          'privatelink.vaultcore.azure.net' // Azure Key Vault
          'privatelink.api.azureml.ms' // Azure Machine Learning Workspace
          'privatelink.notebooks.azure.net' // Azure Machine Learning Workspace (notebooks)
          'privatelink.grafana.azure.com' // Azure Managed Grafana
          'privatelink.media.azure.net' // Azure Media Services
          'privatelink.prod.migration.windowsazure.com' // Azure Migrate
          'privatelink.monitor.azure.com' // Azure Monitor
          'privatelink.oms.opinsights.azure.com' // Azure Monitor OMS
          'privatelink.ods.opinsights.azure.com' // Azure Monitor ODS
          'privatelink.agentsvc.azure-automation.net' // Azure Monitor Agent Service
          'privatelink.redis.cache.windows.net' // Azure Redis Cache
          'privatelink.service.signalr.net' // Azure SignalR
          'privatelink.blob.core.windows.net' // Azure Storage Blob & related services
          'privatelink.dfs.core.windows.net' // Azure Storage DFS
          'privatelink.file.core.windows.net' // Azure Storage File
          'privatelink.queue.core.windows.net' // Azure Storage Queue
          'privatelink.table.core.windows.net' // Azure Storage Table
          'privatelink.web.core.windows.net' // Azure Storage Static Web
          'privatelink.dev.azuresynapse.net' // Azure Synapse Dev
          'privatelink.sql.azuresynapse.net' // Azure Synapse SQL
          'privatelink.wvd.microsoft.com' // Azure Virtual Desktop
          // Add more DNS zone names to audit as needed
        ]
      }
    }
  }
}
