requirejs.config
    paths:
        jquery: "../../node_modules/jquery/dist/jquery"

require [
  "jquery",
  "page_list",
  "config",
  "page"
  "controls",
  "document_viewer"
], ($, PageList, Config, Page, Controls, DocumentViewer) ->
  page_list = new PageList()
  config = new Config(
    page_list: page_list
    $container: $(".js-container")
  )
  controls = new Controls(
    $el: $(".js-controls")
    config: config
    page_list: page_list
  )
  document_viewer = new DocumentViewer(
    $viewport: $(".js-viewport")
    config: config
    page_list: page_list
  )

  example_url = "http://lorempixel.com/400/600/sports"
  document_viewer.add_pages(for i in [1..100]
    $content = $("<div/>",
      class: "page__background"
      style: "background-image: url(#{example_url}/#{i % 11});"
    ).append($("<div/>", class: "page__text", text: "Page #{i}"))
    id: i, $content: $content
  )
