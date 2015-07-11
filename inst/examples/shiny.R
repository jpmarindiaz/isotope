# A nice shiny app
library(shiny)
app <- shinyApp(
  ui = bootstrapPage(
    #Use selectInput instead of selectizeInput in shiny apps for Isotope... might generate conflicts.
    selectInput("filterCols","Seleccione columnas para filtrar",
                   choices = names(d),selected = NULL,multiple = TRUE),
    isotopeOutput("viz")
  ),
  server = function(input, output) {
    d <- read.csv(system.file("data/southAmericaCountries.csv", package = "isotope"))
    output$viz <- renderIsotope({
      #filterCols <- c("idioma","zonaHoraria")
      filterCols <- input$filterCols
      sortCols <- c("población","gdpPerCapita")
      sortCols <- NULL
      isotope(d[-1], filterCols = filterCols, sortCols = sortCols, lang = 'es')
    })
  }
)
runApp(app)
