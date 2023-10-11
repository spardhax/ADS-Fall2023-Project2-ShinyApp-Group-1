library(shiny)

pred_disasters <- "../doc/figs/prediction of disaster numbers.png"
pred_projects <- "../doc/figs/prediction of project numbers.png"

image_names_pred <- c("Prediction of Disaster Numbers", 
                 "Prediction of Project Numbers")

image_data_pred <- data.frame(
  name = image_names_pred, 
  path = c(pred_disasters, pred_projects), 
  stringsAsFactors = FALSE
)

ui4 <- fluidPage(
  titlePanel("Future Predictions"),
  sidebarLayout(
    sidebarPanel(
      selectInput("imageSelectWidget1", "Select an Image:", 
                  choices = image_data_pred$name),
    ),
    mainPanel(
      imageOutput("selectedImageWidget1")
    )
  )
)

server4 <- function(input, output) {
  output$selectedImageWidget1 <- renderImage({
    selected_image_pred <- input$imageSelectWidget1
    
    # Get the file path for the selected image
    selected_image_path_pred <- image_data_pred$path[image_data_pred$name == selected_image_pred]
    
    # Display the selected image
    list(src = selected_image_path_pred, width = "100%")
  }, deleteFile = FALSE)
}