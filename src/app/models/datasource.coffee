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
    incomes:
      fullName:   'Incomes'
      glyphicon:  'glyphicon-piggy-bank'
      sources: [
        { service: "Paypal",      label: "Revenues" }
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
    health:
      fullName:   'Health'
      glyphicon:  'glyphicon-heart'
      sources: []
    it:
      fullName:   'IT'
      glyphicon:  'glyphicon-flash'
      sources: [
        { service: "Website Monitor",   label: "Website uptime" }
      ]

module.exports = DataSource
