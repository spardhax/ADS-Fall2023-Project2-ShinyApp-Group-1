library(shiny)

state_proj_count <- "../doc/figs/stateheatmap.png"

state_fund_total <- "../doc/figs/statewise_mitigated_properties.jpeg"

prop_actions <- "../doc/figs/prop_barplot.png"

image_names <- c("Number of Projects by State", 
                 "Total Program Funding by State", 
                 "Number of Projects by Property Action")

image_data <- data.frame(name = image_names, 
                         path = c(state_proj_count, state_fund_total,
                                  prop_actions), 
                         stringsAsFactors = FALSE)

ui3 <- fluidPage(
  titlePanel("Descriptive Maps and Property Action Totals"),
  sidebarLayout(
    sidebarPanel(
      selectInput("imageSelect", "Select an Image:", choices = image_data$name),
    ),
    mainPanel(
      imageOutput("selectedImage")
    )
  )
)

server3 <- function(input, output) {
  output$selectedImage <- renderImage({
    selected_image <- input$imageSelect
    
    # Get the file path for the selected image
    selected_image_path <- image_data$path[image_data$name == selected_image]
    
    # Display the selected image
    list(src = selected_image_path, width = "100%")
  }, deleteFile = FALSE)
}
