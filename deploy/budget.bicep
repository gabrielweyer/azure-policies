targetScope = 'subscription'

@description('The environment. Valid values: DEV, UAT or PROD.')
@allowed([
  'DEV'
  'UAT'
  'PROD'
])
param environmentType string

@description('Azure will send an email to this address when a threshold is reached. Provided as a parameter so that my email address stays out of the repository.')
param contactEmail string

// Has to be between 0.01 and 1000.
var thresholdPercentage = 130
var timeGrain = 'Monthly'

// The start date must be first of the month in YYYY-MM-DD format. Future start date should not be more than three months. Past start date should be selected within the timegrain period.
var budgetsMap = {
  DEV: [
    {
      budgetName: 'contoso'
      appDomain: 'Contoso'
      startDate: '2022-04-01'
      amount: 50
    }
    {
      budgetName: 'tailwindtraders'
      appDomain: 'TailwindTraders'
      startDate: '2022-04-01'
      amount: 150
    }
  ]
}

var budgetsToCreate = budgetsMap[environmentType]

resource budgets 'Microsoft.Consumption/budgets@2021-10-01' = [for budget in budgetsToCreate: {
  name: budget.budgetName
  properties: {
    timePeriod: {
      startDate: budget.startDate
    }
    timeGrain: timeGrain
    amount: budget.amount
    category: 'Cost'
    notifications: {
      ForecastedThreshold: {
        enabled: true
        thresholdType: 'Forecasted'
        operator: 'GreaterThanOrEqualTo'
        threshold: thresholdPercentage
        contactEmails: [
          contactEmail
        ]
      }
    }
    filter: {
      tags: {
        operator: 'In'
        name: 'AppDomain'
        values: [
          budget.appDomain
        ]
      }
    }
  }
}]
