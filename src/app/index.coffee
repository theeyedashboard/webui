require('lib/setup')
DatasourcesController = require('controllers/datasources_controller')
NavBarController = require('controllers/navbar_controller')

Spine = require('spine')

class App extends Spine.Controller
  constructor: ->
    super

    # create and add navbar
    @navbar = new NavBarController()
    @append @navbar

    # add timeline screen
    @datasources_controller = new DatasourcesController()
    @append @datasources_controller
    @datasources_controller.update()

    # add footer
    @append require("views/footer")({})

module.exports = App
