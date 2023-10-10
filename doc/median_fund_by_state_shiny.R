library(shiny)

# Load your precomputed plots
med_fund_plots <- readRDS("../doc/med_fund_plots.rds")
states <- names(med_fund_plots)

# Sort the state names alphabetically
sorted_states <- sort(states)

ui9 <- fluidPage(
  titlePanel("State Funding Plots"),
  sidebarLayout(
    sidebarPanel(
      textInput("searchState", "Search State:", ""),
      selectInput("stateSelect", "Select State:", choices = sorted_states),
    ),
    mainPanel(
      plotOutput("selectedStatePlot")
    )
  )
)

server9 <- function(input, output, session) {
  # Function to update the selected state based on search input
  observe({
    search_state <- input$searchState
    if (search_state %in% states) {
      updateSelectInput(session, "stateSelect", selected = search_state)
    }
  })
  
  # Render the selected state's plot
  output$selectedStatePlot <- renderPlot({
    selected_state <- input$stateSelect
    if (selected_state %in% states) {
      plot <- med_fund_plots[[selected_state]]
      print(plot)
    } else {
      # Display a message or default plot if the state is not found
      plot(NULL)
    }
  })
}

shinyApp(ui9, server9)
