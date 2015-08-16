require('lib/setup')
TimelineController = require('controllers/timeline_controller')
NavBarController = require('controllers/navbar_controller')

Spine = require('spine')

class App extends Spine.Controller
  constructor: ->
    super

    # create and add navbar
    @navbar = new NavBarController()
    @append @navbar

    # add timeline screen
    @timeline_controller = new TimelineController()
    @append @timeline_controller
    @timeline_controller.update()

    # add footer
    @append require("views/footer")({})

module.exports = App
