# Azure policies

These policies will mark a resource as non-compliant when a required tag is missing or the tag value is invalid. I'm auditing the below tags:

- `AppDomain` expected to contain the name of the service
- `Environment` expected to be either `DEV`, `UAT`, or `PROD`
- `Owner` expected to contain the email address of the team supporting the service

## Deployment

Using the Azure CLI:

```powershell
az deployment sub create --location australiaeast --template-file ./deploy/main.bicep --parameters @deploy/main.parameters.dev.json --name "tagpolicies-$((Get-Date).ToString('yyMMdd-HHmmss'))-$((New-Guid).Guid.Substring(0, 4))"
```

## Design considerations

Each policy needs to be defined twice, once using the `All` mode and once using the `Indexed` mode. This is so that [both resources and resource groups can be audited][resource-manager-modes].

I'm using the [Audit affect][affect-audit] to avoid blocking deployments.

Ideally policies would be defined at the management group scope so that they don't need to be defined for each subscription but that might be unpractical due to how permissions are assigned at your company.

Rather than using parameters and making policies more flexible, I decided to create specific policies for each tags so that the display name and description can be specific.

[affect-audit]: https://docs.microsoft.com/en-au/azure/governance/policy/concepts/effects#audit
[resource-manager-modes]: https://docs.microsoft.com/en-au/azure/governance/policy/concepts/definition-structure#resource-manager-modes
