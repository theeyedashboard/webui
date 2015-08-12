# TimelineController controller
# Author::    Cedric Villa (https://github.com/driket)
# Copyright:: Check licence file
# License::   Check license file

Spine = require('spine')

class TimelineController extends Spine.Controller

  constructor: ->
    super
    @html require("views/timeline/layout")({})

module.exports = TimelineController
