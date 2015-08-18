# DatasourcesController controller
# Author::    Cedric Villa (https://github.com/driket)
# Copyright:: Check licence file
# License::   Check license file

Spine = require('spine')
DataSource = require('../models/datasource')
TimeRangeController = require('controllers/timerange_controller')

class Index extends Spine.Controller

  tag:        'div'
  className:  'view'

  events:
    'click .list-group-item': 'on_category_click'
    'click .graph': 'on_graph_click'

  on_load: =>
    console.log 'loaded'

  constructor: ->
    super()
    Spine.bind('timerange:change', @on_timerange_change)
    # build fake datasources
    @datasources      = DataSource.normalized()
    @current_category = 'social'
    @time_range       = 'last_7_days'
    # refresh view with current datasource
    @update()


  update: =>
    @html require("views/datasources.index")(
      datasources: @datasources,
      current_category: @current_category,
      time_range: @time_range
    )

  on_category_click: (event) =>
    event.preventDefault();
    @current_category = $(event.target).data('category')
    @update()

  on_timerange_change: (time_range) =>
    @time_range = time_range
    @update()

  on_graph_click: (event) =>
    event.preventDefault();
    ds_id = $(event.target).parent().data('id')
    $(event.target).addClass('zoomed')
    setTimeout =>
      @navigate("/datasources",ds_id)
      $(event.target).hide()
    ,100
    setTimeout =>
      $(event.target).removeClass('zoomed')
      $(event.target).show()
    ,200

class Show extends Spine.Controller

  tag:        'div'
  className:  'view'

  constructor: ->
    super()
    Spine.bind('timerange:change', @on_timerange_change)
    @time_range         = 'last_7_days'
    @datasources        = DataSource.all()
    @datasource_id      = '1'
    @update()
    @active (params) =>
      @set_active_source(params.id)

  update: =>
    @html require("views/datasources.show")(
      time_range: @time_range,
      datasource: DataSource.find_by_id(@datasource_id)
    )

  set_active_source: (source_id) =>
    @datasource_id = source_id
    @update()

  on_timerange_change: (time_range) =>
    @time_range = time_range
    @update()

class DatasourcesController extends Spine.Stack
  className: 'root-view stack container'

  controllers:
    show: Show
    index: Index

  default: 'index'

  routes:
    '/datasources':     'index'
    '/datasources/:id': 'show'


module.exports = DatasourcesController
