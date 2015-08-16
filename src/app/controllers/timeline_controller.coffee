# TimelineController controller
# Author::    Cedric Villa (https://github.com/driket)
# Copyright:: Check licence file
# License::   Check license file

Spine = require('spine')
DataSource = require('../models/datasource')
TimeRangeController = require('controllers/timerange_controller')

class TimelineController extends Spine.Controller

  tag:        'div'
  className:  'container'

  events:
    'click .list-group-item': 'on_category_click'

  on_load: =>
    console.log 'loaded'

  constructor: ->
    super()
    # build fake datasources
    @datasources      = DataSource.normalized()
    @current_category = 'social'
    @time_range       = 'last_7_days'
    # refresh view with current datasource
    # @append @timerange_controller
    @update()

  update: =>
    @html require("views/timeline")(
      datasources: @datasources,
      current_category: @current_category,
      time_range: @time_range
    )
    @timerange_controller = new TimeRangeController({el: $('#timerange-selector'), time_range: @time_range})
    @timerange_controller.bind('on_timerange_change', @on_timerange_change)
    # $('#timerange-selector').html(@timerange_controller.el)

  on_category_click: (event) =>
    event.preventDefault();
    @current_category = $(event.target).data('category')
    @update()

  on_timerange_change: (time_range) =>
    @time_range = time_range
    @update()


module.exports = TimelineController
