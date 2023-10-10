library(shiny)
library(ggplot2)

# Load the RDS object containing the list of preprocessed graphs

preprocessed_graphs <- readRDS("../doc/prop_vs_prog_plots.rds")

# Sample data (replace with your own data)
program_areas <- names(preprocessed_graphs)

program_area_descriptions <- list(
  "BRIC" = "The Building Resilient Infrastructure and Communities (BRIC) program helps 
  reduce risks from future disasters and natural hazards",
  "FMA" = "The Flood Mitigation Assistance (FMA) program reduces the risk of flood 
  damage to insured buildings", 
  "HMGP" = "The Hazard Mitigation Assistance Program (HMGP) helps rebuild communities 
  after a major disaster in a way that reduces future disaster losses",
  "LPDM" = "The Legislative Pre-Disaster Mitigation (LPDM) program gives congressionally
  authorized funds to communities  to plan for and implement sustainable 
  cost-effective measures designed to reduce the risk to individuals and property 
  from future natural hazard",
  "PDM" = "The Pre-Disaster Mitigation (PDM) program helps communities plan for 
  and implement sustainable cost-effective measures designed to reduce the risk
  to individuals and property from future natural hazard",
  "RFC" = "The Repetetive Flood Claims (RFC) program provides funding to reduce 
  or eliminate the long-term risk of flood damage to structures insured under the 
  National Flood Insurance Program",
  "SRL" = "The Severe Repetetive Loss (SRL) program seeks to eliminate or reduce the
  damage to residential property and the disruption to life caused by repeated flooding", 
  "All" = "Heat Map of All Programs by Propert Action Type"
)

ui1 <- fluidPage(
  titlePanel("Graph Viewer"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "programAreaFilter",
        "Select Program Area:",
        choices = program_areas
      )
    ),
    mainPanel(
      plotOutput("selectedGraph"), 
      uiOutput("programAreaDescription")
    )
  )
)

server1 <- function(input, output) {
  output$selectedGraph <- renderPlot({
    selected_program_area <- input$programAreaFilter
    selected_graph <- preprocessed_graphs[[selected_program_area]]
    
    # Plot the selected graph
    print(selected_graph)
  })
  
  output$programAreaDescription <- renderUI({
    selected_program_area <- input$programAreaFilter
    description <- program_area_descriptions[[selected_program_area]]
    
    # Create a div with the description
    tags$div(
      HTML(paste0(selected_program_area, ": ")),
      HTML(description)
    )
  })
}
