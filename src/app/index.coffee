require('lib/setup')
DatasourcesController = require('controllers/datasources_controller')
NavBarController = require('controllers/navbar_controller')
TimeRangeController = require('controllers/timerange_controller')

Spine = require('spine')

class App extends Spine.Controller
  constructor: ->
    super
    Spine.Route.setup()

    # create navbar
    @navbar = new NavBarController()
    # create datasources screen
    @datasources_controller = new DatasourcesController()
    @timerange_controller = new TimeRangeController()

    @append @navbar, @timerange_controller, @datasources_controller
    # add footer
    # @append require("views/footer")({})

    @datasources_controller.index.update()


module.exports = App
