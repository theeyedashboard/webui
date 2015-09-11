# GraphsController controller
# Author::    Cedric Villa (https://github.com/driket)
# Copyright:: Check licence file
# License::   Check license file

Spine = require('spine')

class GraphsController extends Spine.Controller

  constructor: (options) ->
    super
    console.log options
    @timerange = options?['timerange'] || 'last_7_days'
    @set_timerange(@timerange)

  set_timerange: (timerange) =>
    console.log 'timerange:', timerange
    @timerange = timerange
    @update()

  update: =>

    if @timerange == 'last_7_days'
      timerange = 7*24*3600*1000
    else if @timerange == 'last_31_days'
      timerange = 31*24*3600*1000
    else if @timerange == 'last_12_month'
      timerange = 12*31*24*3600*1000
    else if @timerange == 'last_3_years'
      timerange = 3*365*24*3600*1000
    else
      timerange = 0

    date_start       = new Date().getTime() - timerange
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

    console.log 'day_counter:', day_counter
    console.log 'resolution:', resolution
    graph_data       = []
    line_color  = "rgba(42, 100, 150, 0.4)"
    line_bw     = "rgba(164, 164, 164, 0.5)"
    bar_width    = 1
    bars_color  = {fillColor: "rgba(42, 100, 150, 0.25)", barWidth: bar_width * 0.8}
    bars_bw     = {fillColor: "rgba(211, 211, 211, 0.5)", barWidth: bar_width * 0.8}
    graph_data.push { data:[], color: line_color , bars: bars_color, shadowSize: 0}

    $.getJSON('/sampler')

      # if json failed
      .fail (jqXHR) =>

        console.log 'Erreur Javascript: ', jqXHR
        # $('.graph-view').spin(false)

      # if json call is successful
      .done (json, textStatus, jqXHR) =>

        $('.graph-view').each (index) =>
          graph_el = $('.graph-view')[index]
          if $(graph_el).is(":visible")
            graph_data = @json_to_graph(json, true, resolution)
            @render_graph(graph_data, graph_el , graph_type, resolution, date_start, date_end)

  json_to_graph: (json, derivative = false, resolution = 'RESOLUTION_HOUR') =>

    samples       = json.samples

    data          = []

    # show values in graph without derivative
    if !derivative

      for sample in samples
        sample.date = sample.date.replace(/-/g,'/')
        data.push [Date.parse(sample.date), sample.value - samples[0].value]

    # show derivative function (differences between values)
    else

      old_value = 0
      old_time  = 0

      for sample in samples

        if resolution == 'RESOLUTION_DAY'
          time = Date.parse(sample.date.replace(/-/g,'/')) - (1000 * 3600 * 24)
        else
          time = Date.parse(sample.date.replace(/-/g,'/'))

        if old_time == 0
          elapsed_days = 1 * 3600 * 24 * 1000
        else
          elapsed_days = (time - old_time) / 3600 / 24 / 1000

        elapsed_days = 1 if elapsed_days < 1
        sample_time = time
        data.push [sample_time, (sample.value - old_value) / elapsed_days]
        old_value = sample.value
        old_time  = time

    if resolution == 'RESOLUTION_HOUR'
      bar_width = 1000 * 3600 * 0.5
    else if resolution == 'RESOLUTION_DAY'
      bar_width = 1000 * 3600 * 24
    else if resolution == 'RESOLUTION_WEEK'
      bar_width = 1000 * 3600 * 24 * 7
    else if resolution == 'RESOLUTION_MONTH'
      bar_width = 1000 * 3600 * 24 * 15

    if derivative
      line_color  = "rgba(42, 100, 150, 0.4)"
      line_bw     = "rgba(164, 164, 164, 0.5)"
      bars_color  = {fillColor: "rgba(42, 100, 150, 0.25)", barWidth: bar_width * 0.8}
      bars_bw     = {fillColor: "rgba(211, 211, 211, 0.5)", barWidth: bar_width * 0.8}
    else
      line_color  = "rgba(42, 100, 150, 0.4)"
      line_bw     = "rgba(164, 164, 164, 0.5)"
      bars_color  = ''
      bars_bw     = ''

    graph_data = []
    graph_data.push { label: 'value', data:data, color: line_color , bars: bars_color, shadowSize: 0,}

    return graph_data

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
        tickFormatter: weekday,
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
        markings: weekendAreas
      tooltip: true,
      tooltipOpts:
        content: "%x - %s: %y",
        xDateFormat: "%d %b %y %h:%M",
    }

    $.plot($(element), graph_data, options )

module.exports = GraphsController
