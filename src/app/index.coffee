require('lib/setup')
TimelineController = require('controllers/timeline_controller')

Spine = require('spine')

class App extends Spine.Controller
  constructor: ->
    super
    timeline_controller = new TimelineController({el: $("body")})

module.exports = App
