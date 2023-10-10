#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#  http://shiny.rstudio.com/
#

library(shiny)
library(forecast)
library(astsa)
library(tseries)
library(dplyr)
library(ggplot2)
library(readr)
library(sqldf)
library(maps)
library(sf)
library(scales)



data<-read_csv('HazardMitigationAssistanceMitigatedProperties_cleaned.csv')

state_map <- map_data("state")
state_data<- data %>%
  group_by(state) %>%
  summarise(total_amount = sum(actualAmountPaid, na.rm = TRUE))

state_data$state <- tolower(state_data$state)

merged <- merge(state_map, state_data, by.x = "region", by.y = "state")

plot1 = ggplot(merged, aes(x = long, y = lat, group = group, fill = total_amount)) +
  geom_polygon() +
  scale_fill_gradient(low = "yellow", high = "red") +
  labs(title = "Statewise Concentration of Mitigated Properties") +
  theme_minimal()

library(readr)
hma <- read_csv("HazardMitigationAssistanceProjects(cleaned).csv")
hma_prop <- read_csv("HazardMitigationAssistanceMitigatedProperties_cleaned.csv")

data_s = sqldf('SELECT LOWER(state) as state, count(*) as count FROM hma GROUP BY state')
state_map = map_data("state")
merged_data_s = sqldf('SELECT cm.*, d.count FROM data_s d INNER JOIN state_map cm ON d.State = cm.region')

plot2 = ggplot(merged_data_s, aes(x = long, y = lat, group = group, fill = count)) +
  geom_polygon() +
  scale_fill_gradient(low = "grey", high = "blue", 
                      name = "Number of Occurances") +
  labs(title = "State-Level Number of Occurances of Mitigation Programs") +
  theme_minimal()

library(maps)
data_c = sqldf('SELECT LOWER(state) as state, LOWER(county) as county, count(*) as count FROM hma GROUP BY state, county')
county_map = map_data("county")
merged_data_c = sqldf('SELECT cm.*, d.count FROM data_c d INNER JOIN county_map cm ON d.State = cm.region AND d.county = cm.subregion')

plot3 = ggplot(merged_data_c, aes(x = long, y = lat, group = group, fill = count)) +
  geom_polygon() +
  scale_fill_gradient(low = "grey", high = "blue") +
  labs(title = "County-Level Number of Occurances of Mitigation Programs") +
  theme_minimal()

data_s = sqldf('SELECT LOWER(state) as state, count(*) as count FROM hma GROUP BY state')
state_map = map_data("state")
merged_data_s = sqldf('SELECT cm.*, d.count FROM data_s d INNER JOIN state_map cm ON d.State = cm.region')

plot4 = ggplot(merged_data_s, aes(x = region, y = count, fill = region)) +
  geom_bar(stat = "identity") +
  labs(x = "State", y = "Count", title = "Bar Plot by State") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 4),
        plot.title = element_text(size = 18),  # Title text size
        axis.title.x = element_text(size = 16),  # X-axis label text size
        axis.title.y = element_text(size = 14), # Y-axis label text size
        axis.text = element_text(size = 16))  # Tick label text size) # Rotate x-axis labels for better readability

data_pa = sqldf('SELECT propertyAction, count(*) as count FROM hma_prop GROUP BY propertyAction HAVING propertyAction is not null')

plot5 = ggplot(data_pa, aes(x = propertyAction, y = count, fill = propertyAction)) +
  geom_bar(stat = "identity") +
  labs(x = "State", y = "Count", title = "Bar Plot of Property Action") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#plot 6 prediction plot
num_of_projects=count(hma,programFy)

# Plot the number of funded projects for each year
test =ggplot(num_of_projects, aes(x = programFy, y = n)) +
  geom_line() +
  labs(x = "Year", y = "Number of Funded Projects", title = "Num of Projects Each Year") +
  theme_minimal()

#Time series
ts1=ts(num_of_projects$n,start=1989,frequency=1)
fit=ets(ts1,model='ANN')

#Predict the number of projects for each of the next three years
plot(forecast(fit,3),main = "Prediction of project numbers",xlab='Year',ylab='Number')


num_of_disasters=count(unique(data[,4:5]),programFy)

# Plot the number of disasters for each year
test = ggplot(num_of_disasters, aes(x = programFy, y = n)) +
  geom_line() +
  labs(x = "Year", y = "Number of Disasters", title = "Num of Disasters Each Year") +
  theme_minimal()

#Time series
ts2=ts(num_of_disasters$n,start=1989,frequency=1)
fit2=ets(ts2,model='ANN')

#Predict the number of projects for each of the next three years
plot(forecast(fit2,3),main = "Prediction of disaster numbers",xlab='Year',ylab='Number')


# Define UI for application that draws a histogram
ui <- navbarPage(

    # Application title
    titlePanel("State Level Heated Map"),
    tabPanel(
      "Static Plots",
    # Sidebar with a slider input for number of bins 
      sidebarLayout(
        sidebarPanel(
          selectInput("plot_choice", "Select a Plot to Display:",
                      choices = c("Statewise Concentration of Mitigated Properties", 
                                  "State-Level Number of Occurances of Mitigation Programs", 
                                  "County-Level Number of Occurances of Mitigation Programs",
                                  "Bar Plot by State",
                                  "Bar Plot of Property Action"),
                      selected = "Statewise Concentration of Mitigated Properties")
      ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("selected_plot")
        )
      )
    ),
    tabPanel(
      "Prediction Plot",
      sidebarLayout(
        sidebarPanel(
          selectInput("prediction_plot_choice", "Select a Plot to Display:",
                      choices = c("Prediction of project numbers", 
                                  "Prediction of disaster numbers"
                                  ),
                      selected = "Prediction of project numbers")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
          plotOutput("prediction_plot")
        )
      )
      
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$selected_plot <- renderPlot({
      
      selected_plots <- input$plot_choice
      
      if ("Statewise Concentration of Mitigated Properties" == selected_plots) {
        # Generate and render Plot 1
        plot1
      }
      
      else if ("State-Level Number of Occurances of Mitigation Programs" == selected_plots) {
        plot2
      }
      
      else if ("County-Level Number of Occurances of Mitigation Programs" == selected_plots) {
        plot3
      }
      else if ("Bar Plot by State" == selected_plots) {
        plot4
      }
      else if ("Bar Plot of Property Action" == selected_plots) {
        plot5
      }
    })
    
  output$prediction_plot <- renderPlot({
    
    selected_plots1 <- input$prediction_plot_choice
    
    if ("Prediction of project numbers" == selected_plots1) {
      # Generate and render Plot 1
      plot(forecast(fit,3),main = "Prediction of project numbers",xlab='Year',ylab='Number')
    }
    else if ("Prediction of disaster numbers" == selected_plots1) {
      plot(forecast(fit2,3),main = "Prediction of disaster numbers",xlab='Year',ylab='Number')
    }
    
      
      
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
