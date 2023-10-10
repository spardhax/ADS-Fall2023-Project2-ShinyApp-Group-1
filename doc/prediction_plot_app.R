library(shiny)

state_proj_count <- "doc/figs/prediction of disaster numbers.png"

state_fund_total <- "doc/figs/prediction of project numbers.png"

image_names <- c("prediction of disaster numbers", 
                 "prediction of project numbers")

image_data <- data.frame(name = image_names, 
                         path = c(state_proj_count, state_fund_total), 
                         stringsAsFactors = FALSE)

ui4 <- fluidPage(
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

server4 <- function(input, output) {
  output$selectedImage <- renderImage({
    selected_image <- input$imageSelect
    
    # Get the file path for the selected image
    selected_image_path <- image_data$path[image_data$name == selected_image]
    
    # Display the selected image
    list(src = selected_image_path, width = "100%")
  }, deleteFile = FALSE)
}

shinyApp(ui4, server4)