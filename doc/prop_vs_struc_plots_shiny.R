library(shiny)
library(ggplot2)

# Load the RDS object containing the list of preprocessed graphs

preprocessed_graphs2 <- readRDS("../doc/prop_vs_struc_plots.rds")

# Sample data (replace with your own data)
program_areas2 <- names(preprocessed_graphs2)

program_area_descriptions2 <- list(
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
  "Total" = "Proportion of Project Grants by Property Type"
)

ui2 <- fluidPage(
  titlePanel("Graph Viewer 2"),  # Updated title
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "programAreaFilter2",  # Updated input ID
        "Select Program Area:",
        choices = program_areas
      )
    ),
    mainPanel(
      plotOutput("selectedGraph2"),  # Updated output ID
      uiOutput("programAreaDescription2")  # Updated output ID
    )
  )
)

server2 <- function(input, output) {
  output$selectedGraph2 <- renderPlot({
    selected_program_area2 <- input$programAreaFilter2  # Updated input ID
    selected_graph2 <- preprocessed_graphs2[[selected_program_area2]]
    
    # Plot the selected graph
    print(selected_graph2)
  })
  
  output$programAreaDescription2 <- renderUI({
    selected_program_area2 <- input$programAreaFilter2  # Updated input ID
    description <- program_area_descriptions2[[selected_program_area2]]
    
    # Create a div with the description
    tags$div(
      HTML(paste0(selected_program_area2, ": ")),
      HTML(description)
    )
  })
}
