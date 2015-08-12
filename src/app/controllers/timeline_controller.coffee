# TimelineController controller
# Author::    Cedric Villa (https://github.com/driket)
# Copyright:: Check licence file
# License::   Check license file

Spine = require('spine')
NavBarController = require('controllers/navbar_controller')

class TimelineController extends Spine.Controller

  constructor: ->
    super
    # build fake datasources
    @datasources = @fake_datasources()

    # create and add navbar
    @navbar = new NavBarController
    @append @navbar.view

    # add self view
    @append @view

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

  view: =>
    require("views/timeline/layout")({datasources: @fake_datasources().marketing})

module.exports = TimelineController
