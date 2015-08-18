# NavBarController controller
# Author::    Cedric Villa (https://github.com/driket)
# Copyright:: Check licence file
# License::   Check license file

Spine = require('spine')

class NavBarController extends Spine.Controller

  events:
    'click .sources-button': 'on_sources_click'

  constructor: ->
    super
    @update()

  update: =>
    @html require("views/navbar")({})

  on_sources_click: =>
    @navigate("/datasources")

module.exports = NavBarController
