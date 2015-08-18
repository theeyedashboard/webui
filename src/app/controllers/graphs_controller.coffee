# GraphsController controller
# Author::    Cedric Villa (https://github.com/driket)
# Copyright:: Check licence file
# License::   Check license file

Spine = require('spine')

class GraphsController extends Spine.Controller

  constructor: ->
    super
    @update()

  update: =>
    date_start       = new Date().getTime() - 7*24*3600*1000
    date_end         = new Date().getTime()
    mode             = 'normal'
    graph_type       = 'line'
    day_counter = (date_end - date_start) / 1000 / 3600 / 24

    if day_counter <= 7
      resolution = 'RESOLUTION_HOUR'
    else if day_counter < 365
      resolution = 'RESOLUTION_DAY'
    else
      resolution = 'RESOLUTION_MONTH'

    graph_data       = []
    line_color  = "rgba(42, 100, 150, 0.4)"
    line_bw     = "rgba(164, 164, 164, 0.5)"
    bar_width    = 1
    bars_color  = {fillColor: "rgba(42, 100, 150, 0.25)", barWidth: bar_width * 0.8}
    bars_bw     = {fillColor: "rgba(211, 211, 211, 0.5)", barWidth: bar_width * 0.8}
    graph_data.push { label: 'total', data:[], color: line_color , bars: bars_color, shadowSize: 0}

    $('.graph-view').each (index) =>
      @render_graph(graph_data, $('.graph-view')[index] , graph_type, resolution, date_start, date_end)

  # render graph from graph data
  # Params::
  # +graph data+::  json graph data
  # +element+:: jquery element to render in
  # +graph_type+:: line or bars
  # +resolution:: RESOLUTION_[HOUR/DAY/MONTH]
  # +date_start:: graph x axis start (time)
  # +date_end:: graph x axis end (time)
  render_graph: (graph_data, element, graph_type, resolution, date_start, date_end) ->

    line = false
    line = (graph_type == 'line')

    # setup time format
    if resolution == 'RESOLUTION_HOUR'
      timeformat = "%d/%m %h:%M"
    else
      timeformat = "%d %b %y"

    time_axis = {
      mode: 'time',
      timeformat: timeformat,
      min: date_start,
      max: date_end,
    }

    # setup axes
    axes = []

    if resolution == 'RESOLUTION_HOUR'
      day_axis = {
        mode: "time",
        # tickFormatter: weekday,
        color: "rgba(0,0,0,0.05)",
        position: "top",
        axisLabel: "Weekday",
        axisLabelUseCanvas: false,
        axisLabelFontSizePixels: 12,
        axisLabelFontFamily: 'Verdana, Arial',
        axisLabelPadding: 5,
        min: date_start,
        max: date_end,
      }
      axes.push day_axis

    axes.push time_axis

    options = {
      xaxes: axes,
      yaxis: {
      },
      lines: {show: line},
      points: {show: false},
      color: "rgba(0,0,0,0)",
      bars: { show: !line },
      series:
        lines:
          lineWidth: 1
          show: true
          fill: 0.2
        points:
          show: false
        stack: true
      grid:
        hoverable: true
        clickable: true
        color: "#eee"
        # markings: weekendAreas
      tooltip: true,
      tooltipOpts:
        content: "%x - %s: %y",
        xDateFormat: "%d %b %y %h:%M",
    }

    $.plot($(element), graph_data, options )

module.exports = GraphsController
