# TimelineController controller
# Author::    Cedric Villa (https://github.com/driket)
# Copyright:: Check licence file
# License::   Check license file

Spine = require('spine')

class TimelineController extends Spine.Controller

  tag:        'div'
  className:  'container'

  events:
    'click .list-group-item': 'on_category_click'

  constructor: ->
    super
    # build fake datasources
    @datasources = @fake_datasources()
    @current_category = 'social'
    @update()

  fake_datasources: =>
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

  update: =>
    @html require("views/timeline")({datasources: @datasources[@current_category]})

  on_category_click: (event) =>
    @current_category = $(event.target).data('category')
    @update()

module.exports = TimelineController
