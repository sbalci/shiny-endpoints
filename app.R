library(shiny)

shiny::addResourcePath("assets", "assets")

endpoint <- function(data, req) {
  query <- parseQueryString(req$QUERY_STRING)

  Sys.sleep(5L)

  httpResponse(
    status = 200L,
    content_type = "application/json",
    content = jsonlite::toJSON(
      cars[[query$variable]],
      auto_unbox = TRUE
    )
  )
}

ui <- fluidPage(
  tags$script(
    src = "assets/script.js"
  ),
  tags$button(
    id = "show",
    class = "btn btn-info",
    "Show data"
  ),
  selectInput(
    "variable",
    "Variable",
    choices = names(cars)
  ),
  tags$ul(
    id = "list"
  )
)

server <- function(input, output, session) {
  path <- session$registerDataObj(
    "data",
    data = cars,
    filterFunc = endpoint
  )

  session$sendCustomMessage(
    "path",
    path
  )
}

shinyApp(ui, server)
