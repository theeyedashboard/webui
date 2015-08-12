require('lib/setup')
TimelineController = require('controllers/timeline_controller')

Spine = require('spine')

class App extends Spine.Controller
  constructor: ->
    super
    console.log 'yeah'
    # Getting started - should be removed
    timeline_controller = new TimelineController({el: $("body")})
    # @html require("views/sample")({version:Spine.version})

module.exports = App
