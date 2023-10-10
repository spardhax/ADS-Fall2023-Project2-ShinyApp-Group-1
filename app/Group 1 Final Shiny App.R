library(shiny)

source("../doc/prop_vs_prog_plots_shiny.R", local = TRUE)

source("../doc/prop_vs_struc_plots_shiny.R", local = TRUE)

source("../doc/median_fund_by_state_shiny.R", local = TRUE)

ui <- fluidPage(
  titlePanel("FEMA Hazard Mitigation Projects: A Breakdown Analysis"),
  tabsetPanel(
    tabPanel("Property Actions by Program", ui1),
    tabPanel("Structure Types by Program", ui2),
    tabPanel("Median Funding by State/Year", ui9)
  )
)

server <- function(input, output) {
  server1(input, output)
  server2(input, output)
  server9(input, output)
}

shinyApp(ui, server)