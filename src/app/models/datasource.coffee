class DataSource

  constructor: (args) ->
    # body...

  @all: =>
    social: [
      { service: "Facebook",    label: "Page subscription" }
      { service: "Twitter",     label: "Followers" }
      { service: "Instagram",   label: "Followers" }
    ],
    incomes: [
      { service: "Paypal",      label: "Revenues" }
    ],
    marketing: [
      { service: "Mailchimp",   label: "Mail opening" }
      { service: "Mailchimp",   label: "Mail actions" }
    ],
    productivity: [

    ],
    health: [

    ],
    it: [
      { service: "Website Monitor",   label: "Website uptime" }
    ]

module.exports = DataSource
