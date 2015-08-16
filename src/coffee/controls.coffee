define [
  "jquery",
  "controls/zoom",
  "controls/pagination"
], ($, Zoom, Pagination) ->
  class Controls
    constructor: (options = {}) ->
      @$el = options.$el
      @config = options.config
      @page_list = options.page_list
      @zoom = new Zoom(
        $el: @$el.find(".js-controls-zoom")
        config: @config
      )
      @pagination = new Pagination(
        $el: @$el.find(".js-controls-pagination")
        config: @config
        page_list: @page_list
      )
