class DataSource

  @all: =>
    social:
      fullName:   'Social'
      glyphicon:  'glyphicon-user'
      sources: [
        { service: "Facebook",    label: "Page subscription" }
        { service: "Twitter",     label: "Followers" }
        { service: "Instagram",   label: "Followers" }
      ],
    financial:
      fullName:   'Financial'
      glyphicon:  'glyphicon-piggy-bank'
      sources: [
        { service: "Paypal",      label: "Revenues" }
      ],
    ecommerce:
      fullName:   'E-commerce'
      glyphicon:  'glyphicon-shopping-cart'
      sources: [
        { service: "Shopify",      label: "Sales" }
        { service: "Shopify",      label: "Revenue per user" }
      ],
    marketing:
      fullName:   'Marketing'
      glyphicon:  'glyphicon-bullhorn'
      sources: [
        { service: "Mailchimp",   label: "Mail opening" }
        { service: "Mailchimp",   label: "Mail actions" }
      ],
    productivity:
      fullName:   'Productivity'
      glyphicon:  'glyphicon-send'
      sources: []
    # health:
    #   fullName:   'Health'
    #   glyphicon:  'glyphicon-heart'
    #   sources: []
    it:
      fullName:   'IT'
      glyphicon:  'glyphicon-flash'
      sources: [
        { service: "Website Monitor",   label: "Website uptime" }
      ]

module.exports = DataSource
