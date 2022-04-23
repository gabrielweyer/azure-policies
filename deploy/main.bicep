@description('The environment this subscription is used for.')
@allowed([
  'DEV'
  'UAT'
  'PROD'
])
param environmentType string

@description('The organisation this subscription is used for.')
@allowed([
  'Contoso'
  'TailwindTraders'
])
param organisation string

targetScope = 'subscription'

var appDomainTagResourcePolicyName = '25a51682-b81c-4c1e-939c-8d94d998b958'
resource appDomainTagResourcePolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: appDomainTagResourcePolicyName
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    description: 'This is the name of the service (Invoice, Print...). Applies to resources.'
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
    description: 'This is the name of the service (Invoice, Print...). Applies to resource groups.'
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

var environmentTagResourcePolicyName = 'c1da789b-6a17-4235-a686-0c7a58aa46bc'
resource environmentTagResourcePolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: environmentTagResourcePolicyName
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    description: 'The value should match the subscription name. Applies to resources.'
    displayName: 'Audit \'Environment\' tag with a value of \'${environmentType}\' (resource)'
    metadata: {
      category: 'Tags'
      version: '0.0.1'
    }
    parameters: {}
    policyRule: {
      if: {
        field: 'tags[\'Environment\']'
        notEquals: environmentType
      }
      then: {
        effect: 'Audit'
      }
    }
  }
}

var environmentTagResourceGroupPolicyName = '8844241b-0eb8-4551-8742-1713ac8fc56f'
resource environmentTagResourceGroupPolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: environmentTagResourceGroupPolicyName
  properties: {
    policyType: 'Custom'
    mode: 'All'
    description: 'The value should match the subscription name. Applies to resource groups.'
    displayName: 'Audit \'Environment\' tag with a value of \'${environmentType}\' (resource group)'
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
            field: 'tags[\'Environment\']'
            notEquals: environmentType
          }
        ]
      }
      then: {
        effect: 'Audit'
      }
    }
  }
}

var organisationTagResourcePolicyName = 'afe09846-6fc2-4d12-ae37-8feaf0bc6be5'
resource organisationTagResourcePolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: organisationTagResourcePolicyName
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    description: 'The value should match the subscription name. Applies to resources.'
    displayName: 'Audit \'Organisation\' tag with a value of \'${organisation}\' (resource)'
    metadata: {
      category: 'Tags'
      version: '0.0.1'
    }
    parameters: {}
    policyRule: {
      if: {
        field: 'tags[\'Organisation\']'
        notEquals: organisation
      }
      then: {
        effect: 'Audit'
      }
    }
  }
}

var organisationTagResourceGroupPolicyName = '36eaf862-d2a5-4c23-a6e1-3641d89eaf9c'
resource organisationTagResourceGroupPolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: organisationTagResourceGroupPolicyName
  properties: {
    policyType: 'Custom'
    mode: 'All'
    description: 'The value should match the subscription name. Applies to resource groups.'
    displayName: 'Audit \'Organisation\' tag with a value of \'${organisation}\' (resource group)'
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
            field: 'tags[\'Organisation\']'
            notEquals: organisation
          }
        ]
      }
      then: {
        effect: 'Audit'
      }
    }
  }
}

var ownerTagResourcePolicyName = 'f3927374-6b04-431e-a535-4bf83a164c37'
resource ownerTagResourcePolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: ownerTagResourcePolicyName
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    description: 'This is the email address of the team supporting the service. Applies to resources.'
    displayName: 'Audit \'Owner\' tag (resource)'
    metadata: {
      category: 'Tags'
      version: '0.0.1'
    }
    parameters: {}
    policyRule: {
      if: {
        field: 'tags[\'Owner\']'
        exists: false
      }
      then: {
        effect: 'Audit'
      }
    }
  }
}

var ownerTagResourceGroupPolicyName = '25c40a1b-1750-4167-8af2-9f231eda52b8'
resource ownerTagResourceGroupPolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: ownerTagResourceGroupPolicyName
  properties: {
    policyType: 'Custom'
    mode: 'All'
    description: 'This is the email address of the team supporting the service. Applies to resource groups.'
    displayName: 'Audit \'Owner\' tag (resource group)'
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
            field: 'tags[\'Owner\']'
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
    description: 'The \'Organisation\' and \'Environment\' have to match the subscription name (${organisation} ${environmentType}). Applies to both resources and resource groups.'
    displayName: 'Audit \'AppDomain\', \'Environment\', \'Organisation\', and \'Owner\' tags'
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
      {
        groupNames: [
        ]
        parameters: {}
        policyDefinitionId: environmentTagResourcePolicy.id
        policyDefinitionReferenceId: environmentTagResourcePolicy.id
      }
      {
        groupNames: [
        ]
        parameters: {}
        policyDefinitionId: environmentTagResourceGroupPolicy.id
        policyDefinitionReferenceId: environmentTagResourceGroupPolicy.id
      }
      {
        groupNames: [
        ]
        parameters: {}
        policyDefinitionId: organisationTagResourcePolicy.id
        policyDefinitionReferenceId: organisationTagResourcePolicy.id
      }
      {
        groupNames: [
        ]
        parameters: {}
        policyDefinitionId: organisationTagResourceGroupPolicy.id
        policyDefinitionReferenceId: organisationTagResourceGroupPolicy.id
      }
      {
        groupNames: [
        ]
        parameters: {}
        policyDefinitionId: ownerTagResourcePolicy.id
        policyDefinitionReferenceId: ownerTagResourcePolicy.id
      }
      {
        groupNames: [
        ]
        parameters: {}
        policyDefinitionId: ownerTagResourceGroupPolicy.id
        policyDefinitionReferenceId: ownerTagResourceGroupPolicy.id
      }
    ]
    policyType: 'Custom'
  }
}

var tagsInitiativeAssignmentName = '3561d44c-c518-47e1-bec1-482368fbdc16'
resource tagsInitiativeAssignment 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: tagsInitiativeAssignmentName
  properties: {
    description: 'Audit missing or invalid tags for ${environmentType} subscription'
    displayName: 'Audit tags (subscription: ${subscription().subscriptionId})'
    enforcementMode: 'Default'
    metadata: {
      category: 'Tags'
      version: '0.0.1'
    }
    nonComplianceMessages: [
      {
        message: 'The resource does not have the expected \'AppDomain\' tag.'
        policyDefinitionReferenceId: appDomainTagResourcePolicy.id
      }
      {
        message: 'The resource group does not have the expected \'AppDomain\' tag.'
        policyDefinitionReferenceId: appDomainTagResourceGroupPolicy.id
      }
      {
        message: 'The resource does not have the expected \'Environment\': \'${environmentType}\' tag.'
        policyDefinitionReferenceId: environmentTagResourcePolicy.id
      }
      {
        message: 'The resource group does not have the expected \'Environment\': \'${environmentType}\' tag.'
        policyDefinitionReferenceId: environmentTagResourceGroupPolicy.id
      }
      {
        message: 'The resource does not have the expected \'Organisation\': \'${organisation}\' tag.'
        policyDefinitionReferenceId: organisationTagResourcePolicy.id
      }
      {
        message: 'The resource group does not have the expected \'Organisation\': \'${organisation}\' tag.'
        policyDefinitionReferenceId: organisationTagResourceGroupPolicy.id
      }
      {
        message: 'The resource does not have the expected \'Owner\' tag.'
        policyDefinitionReferenceId: ownerTagResourcePolicy.id
      }
      {
        message: 'The resource group does not have the expected \'Owner\' tag.'
        policyDefinitionReferenceId: ownerTagResourceGroupPolicy.id
      }
    ]
    notScopes: [
    ]
    parameters: {}
    policyDefinitionId: tagsInitiative.id
  }
}
