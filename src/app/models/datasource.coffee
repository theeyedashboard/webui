Category = require('./category')

class DataSource

  @all: => [
    service:  "Facebook"
    label:    "Page subscription"
    category: 'social'
    last_7_days:
      total: '15'
    last_31_days:
      total: '65'
    last_12_month:
      total: '783'
    last_3_years:
      total: '2 342'
  ,
    service:  "Twitter"
    label:    "Followers"
    category: 'social'
    last_7_days:
      total: '11'
    last_31_days:
      total: '56'
    last_12_month:
      total: '725'
    last_3_years:
      total: '1 259'
  ,
    service:  "Instagram"
    label:    "Followers"
    category: 'social'
    last_7_days:
      total: '12'
    last_31_days:
      total: '57'
    last_12_month:
      total: '728'
    last_3_years:
      total: '1 220'
  ,
    service:  "Paypal"
    label:    "Revenues"
    category: 'financial'
    last_7_days:
      total: '730'
    last_31_days:
      total: '3 218'
    last_12_month:
      total: '39 126'
    last_3_years:
      total: '39 126'
    unit: '€'
  ,
    service:  "Shopify"
    label:    "Sales"
    category: 'ecommerce'
  ,
    service:  "Shopify"
    label:    "Revenue per user"
    category: 'ecommerce'
  ,
    service:  "Mailchimp"
    label:    "Mail opening"
    category: 'marketing'
  ,
    service:  "Mailchimp"
    label:    "Mail actions"
    category: 'marketing'
  ,
    service:  "Website Monitor"
    label:    "Website uptime"
    category: 'it'
  ]

  # return normalized categories with embedded datasources
  @normalized: =>
    @embedded_datasources = Category.all()

    # add sources field to embed data sources
    for name, category of @embedded_datasources
      category.sources = []

    for datasource in @all()
      # append current source in existing category if it exists
      if @embedded_datasources[datasource.category]
        @embedded_datasources[datasource.category].sources.push datasource
      # else append current source in "other" category
      else
        @embedded_datasources['other'].sources.push datasource

    return @embedded_datasources


module.exports = DataSource
