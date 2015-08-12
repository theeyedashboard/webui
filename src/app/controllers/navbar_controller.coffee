# NavBarController controller
# Author::    Cedric Villa (https://github.com/driket)
# Copyright:: Check licence file
# License::   Check license file

Spine = require('spine')

class NavBarController extends Spine.Controller

  constructor: ->
    super

  view: =>
    @html require("views/navbar")({})

module.exports = NavBarController
