targetScope = 'subscription'

var appDomainTagResourcePolicyName = '25a51682-b81c-4c1e-939c-8d94d998b958'
resource appDomainTagResourcePolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: appDomainTagResourcePolicyName
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    description: 'Any value is valid, applies to resources. This is the name of the service (Invoice, Print...).'
    displayName: 'Audit \'AppDomain\' tag (resource)'
    metadata: {
      category: 'Tags'
      version: '0.0.1'
    }
    parameters: {}
    policyRule: {
      if: {
        field: 'tags[\'AppDomain\']'
        exists: false
      }
      then: {
        effect: 'Audit'
      }
    }
  }
}

var appDomainTagResourceGroupPolicyName = 'fc086375-ae27-4606-b281-61a1b1151902'
resource appDomainTagResourceGroupPolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: appDomainTagResourceGroupPolicyName
  properties: {
    policyType: 'Custom'
    mode: 'All'
    description: 'Any value is valid, applies to resource groups. This is the name of the service (Invoice, Print...).'
    displayName: 'Audit \'AppDomain\' tag (resource group)'
    metadata: {
      category: 'Tags'
      version: '0.0.1'
    }
    parameters: {}
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Resources/subscriptions/resourceGroups'
          }
          {
            field: 'tags[\'AppDomain\']'
            exists: false
          }
        ]
      }
      then: {
        effect: 'Audit'
      }
    }
  }
}

var tagsInitiativeName = '19957755-223d-43c0-aab5-e42b707769ff'
resource tagsInitiative 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: tagsInitiativeName
  properties: {
    description: 'Applies to both resource and resource groups.'
    displayName: 'Audit \'AppDomain\' tag'
    metadata: {
      category: 'Tags'
      version: '0.0.1'
    }
    parameters: {}
    policyDefinitionGroups: [
    ]
    policyDefinitions: [
      {
        groupNames: [
        ]
        parameters: {}
        policyDefinitionId: appDomainTagResourcePolicy.id
        policyDefinitionReferenceId: appDomainTagResourcePolicy.id
      }
      {
        groupNames: [
        ]
        parameters: {}
        policyDefinitionId: appDomainTagResourceGroupPolicy.id
        policyDefinitionReferenceId: appDomainTagResourceGroupPolicy.id
      }
    ]
    policyType: 'Custom'
  }
}
