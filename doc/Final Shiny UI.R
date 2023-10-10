library(shiny)

# Load UI and server logic for Widget 1
source("prop_vs_prog_plots_shiny.R", local = TRUE)

# Load UI and server logic for Widget 2
source("prop_vs_struc_plots_shiny.R", local = TRUE)

ui <- fluidPage(
  titlePanel("Combined Shiny App"),
  tabsetPanel(
    tabPanel("Widget 1", ui1),
    tabPanel("Widget 2", ui2)
  )
)

server <- function(input, output) {
  server1(input, output)
  server2(input, output)
}

shinyApp(ui, server)
