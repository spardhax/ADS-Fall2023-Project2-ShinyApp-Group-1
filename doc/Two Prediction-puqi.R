library(forecast)
library(astsa)
library(tseries)
library(dplyr)
library(ggplot2)


# reading the file
data<-read.csv('C:/Users/spq/Desktop/HazardMitigationAssistanceProjects(cleaned).csv')
num_of_projects=count(data,programFy)

# Plot the number of funded projects for each year
ggplot(num_of_projects, aes(x = programFy, y = n)) +
  geom_line() +
  labs(x = "Year", y = "Number of Funded Projects", title = "Num of Projects Each Year") +
  theme_minimal()

#Time series
ts1=ts(num_of_projects$n,start=1989,frequency=1)
fit=ets(ts1,model='ANN')

#Predict the number of projects for each of the next three years
plot(forecast(fit,3),main = "Prediction of project numbers",xlab='Year',ylab='Number')




# reading the file
data1<-read.csv('C:/Users/spq/Desktop/HazardMitigationAssistanceMitigatedProperties_cleaned.csv')
num_of_disasters=count(unique(data1[,4:5]),programFy)

# Plot the number of disasters for each year
ggplot(num_of_disasters, aes(x = programFy, y = n)) +
  geom_line() +
  labs(x = "Year", y = "Number of Disasters", title = "Num of Disasters Each Year") +
  theme_minimal()

#Time series
ts2=ts(num_of_disasters$n,start=1989,frequency=1)
fit2=ets(ts2,model='ANN')

#Predict the number of projects for each of the next three years
plot(forecast(fit2,3),main = "Prediction of disaster numbers",xlab='Year',ylab='Number')

