# TimeRangeController controller
# Author::    Cedric Villa (https://github.com/driket)
# Copyright:: Check licence file
# License::   Check license file

Spine = require('spine')

class TimeRangeController extends Spine.Controller

  tag:        'div'
  className:  'timerange-selector container'

  events:
    'click .dropdown-menu a': 'on_timerange_selector_click'

  constructor: ->
    super
    @time_range ||= 'last_7_days'
    # refresh view with current datasource
    @update()

  update: =>
    @html require("views/_timerange")(
      time_range: @time_range,
      label:      @label_for_timerange(@time_range)
    )

  time_ranges: =>
    last_7_days:
      label: 'Last 7 days'
    last_31_days:
      label: 'Last 31 days'
    last_12_month:
      label: 'Last 12 month'
    last_3_years:
      label: 'Last 3 years'

  label_for_timerange:(timerange) =>
    if (@time_ranges()[timerange])
      return @time_ranges()[timerange].label
    else
      return "Unknown"

  on_timerange_selector_click: (event) =>
    event.preventDefault();
    @time_range = $(event.target).data('timerange')
    console.log 'timerange change', @time_range
    @update()
    Spine.trigger('timerange:change', @time_range)

module.exports = TimeRangeController
