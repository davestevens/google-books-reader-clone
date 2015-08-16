define ["jquery"], ($) ->
  class Page
    constructor: (options) ->
      @id = options.id
      @index = options.index
      @$content = options.$content
      @config = options.config

    render: ->
      console.log "Rendering page #{@id}" if window.debug
      @$view = $("<div />", class: "page")
        .css(@_style())
        .append(@$content)
      @config.$container.append(@$view)

    update: -> @$view.css(@_style())

    remove: ->
      console.log "Removing page #{@id}" if window.debug
      @$view.remove()

    offset: -> @config.total_height * @index + @config.spacing

    _style: ->
      top: @offset()
      width: @config.width
      height: @config.height
