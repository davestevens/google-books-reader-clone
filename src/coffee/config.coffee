define ["jquery"], ($) ->
  # Config
  # Events:
  # updates - when there have been any updates to config options
  class Config
    constructor: (options = {}) ->
      @original_width = @width = options.width || 400
      @original_height = @height = options.height || 600
      @original_spacing = @spacing = options.spacing || 20
      @total_height = @height + @spacing
      @$container = options.$container

    update: (options) ->
      @[key] = value for key, value of options
      @total_height =  @height + @spacing
      @publish("updated")

    publish: (name, data) -> $(@).trigger(name, data)

    subscribe: (name, callback) -> $(@).on(name, callback)
