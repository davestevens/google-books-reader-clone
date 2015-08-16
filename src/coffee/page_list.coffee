define ["jquery", "page"], ($, Page) ->
  # PageList
  # Events:
  # added - when page is added, includes added page & total page count
  # jump - when going to direct page, includes page
  # scrolled - when page is changed due to scrolling, include page
  class PageList
    constructor: (options = {}) ->
      @current = null
      @pages = []
      @rendered = []
      @page_class = options.page_class || Page

    add: (options) ->
      options = $.extend({ index: @pages.length }, options)
      page = new @page_class(options)
      @pages.push(page)
      @publish("added", page: page, total: @pages.length)

    refresh: ->
      page.update() for page in @rendered
      @publish("jump", @current)

    count: -> @pages.length

    section: (start, end) -> @pages.slice(start, end + 1)

    find: (id) -> @pages.filter((i) -> i.id == +id)

    update: (expected) ->
      page.render() for page in expected.filter((i) => @rendered.indexOf(i) < 0)
      page.remove() for page in @rendered.filter((i) => expected.indexOf(i) < 0)
      @rendered = expected

    to: (value) ->
      @current = @pages[value]
      @publish("scrolled", @current)

    changed: (value) -> @pages.indexOf(@current) != value

    next: -> @jump_to(Math.min(@pages.length - 1, @pages.indexOf(@current) + 1))

    previous: -> @jump_to(Math.max(0, @pages.indexOf(@current) - 1))

    first: -> @jump_to(0)

    last: -> @jump_to(@pages.length - 1)

    publish: (name, data) -> $(@).trigger(name, data)

    subscribe: (name, callback) -> $(@).on(name, callback)

    jump_to: (index) -> @publish("jump", @pages[index])
