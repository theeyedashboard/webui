# TimelineController controller
# Author::    Cedric Villa (https://github.com/driket)
# Copyright:: Check licence file
# License::   Check license file

Spine = require('spine')
DataSource = require('../models/datasource')

class TimelineController extends Spine.Controller

  tag:        'div'
  className:  'container'

  events:
    'click .list-group-item': 'on_category_click'

  constructor: ->
    super
    # build fake datasources
    @datasources = DataSource.all()
    @current_category = 'social'
    @update()

  update: =>
    @html require("views/timeline")({datasources: @datasources[@current_category]})

  on_category_click: (event) =>
    @current_category = $(event.target).data('category')
    @update()

module.exports = TimelineController
