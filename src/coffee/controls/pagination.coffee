define ["jquery"], ($) ->
  class Pagination
    constructor: (options = {}) ->
      @$el = options.$el
      @config = options.config
      @page_list = options.page_list
      @value = options.value || 1
      @$label = @$el.find(".js-pagination-current")
      @$total = @$el.find(".js-pagination-total")
      @_bind_events()

    _bind_events: ->
      @$el.on("click", ".js-pagination", @_jump_to)
      @$el.on("change", @$label, @_skip_to)
      @page_list.subscribe("scrolled", @_scrolled)
      @page_list.subscribe("added", @_page_added)

    _page_added: (_event, data) => @$total.text(data.total)

    _scrolled: (_event, page) =>
      console.log "Scrolled to #{page.id}" if window.debug
      @$label.val(page.id)

    _jump_to: (event) =>
      method = $(event.target).data("method")
      @page_list[method]()

    _skip_to: (event) =>
      page = @page_list.find($(event.target).val())
      @page_list.publish("jump", page)
