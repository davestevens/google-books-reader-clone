define ["jquery", "page_list"], ($, PageList) ->
  class DocumentViewer
    constructor: (options) ->
      @page_list = options.page_list || new PageList()
      @$viewport = options.$viewport
      @config = options.config
      @window_size = @_calculate_window_size()
      @_bind_events()

    _bind_events: ->
      @config.subscribe("updated", (_event) =>
        @_update_container()
        @page_list.refresh()
      )

      @page_list.subscribe("jump", (_event, page) =>
        console.log "Skipping to page #{page.id}" if window.debug
        @$viewport.scrollTop(page.offset())
      )

      @$viewport.on("scroll", @update.bind(@))

    add_page: (options) ->
      @page_list.add($.extend({ config: @config }, options))
      @_update_container()
      @update()

    add_pages: (pages_options) ->
      for options in pages_options
        @page_list.add($.extend({ config: @config }, options))
      @_update_container()
      @update()

    update: ->
      current = @_current()
      return if !@page_list.changed(current)
      expected_rendered = @_expected_rendered(current)
      @page_list.update(expected_rendered)
      @page_list.to(current)

    _calculate_window_size: ->
      Math.ceil(@$viewport.height() / @config.total_height)

    _update_container: ->
      height = (@config.total_height * @page_list.count()) + @config.spacing
      @config.$container.css(height: height, width: @config.width)

    _current: ->
      offset = @$viewport.scrollTop()
      Math.floor(offset / @config.total_height)

    _expected_rendered: (page_index) ->
        start = Math.max(0, page_index - @window_size)
        end = Math.min(@page_list.count(), page_index + @window_size)
        @page_list.section(start, end)
