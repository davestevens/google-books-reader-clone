define ["jquery"], ($) ->
  class Zoom
    constructor: (options = {}) ->
      @$el = options.$el
      @config = options.config
      @value = options.value || 100
      @step = options.step || 25
      @$label = @$el.find(".js-zoom-level").text(@value)
      @_bind_events()

    _bind_events: ->
      @$el.on("click", ".js-zoom-out", @_out)
      @$el.on("click", ".js-zoom-in", @_in)

    _in: => @_update(Math.min(250, @value + @step))

    _out: => @_update(Math.max(50, @value - @step))

    _update: (value) ->
      return if value == @value
      previous = @value
      @value = value
      console.log "Zooming to #{@value}%" if window.debug
      @$label.text(@value)
      # Updates the values in the Config object
      scaling_factor = @value / 100
      @config.update(
        width: @config.original_width * scaling_factor
        height: @config.original_height * scaling_factor
        spacing: @config.original_spacing * scaling_factor
      )
