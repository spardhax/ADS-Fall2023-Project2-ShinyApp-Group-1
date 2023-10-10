library(stringr)

data=read.csv('https://www.fema.gov/api/open/v3/HazardMitigationAssistanceProjects.csv')
data[data == ''] = NA #Find NAs

data$subrecipient=str_to_title(data$subrecipient) #Change the case of words
data$dateApproved=substr(data$dateApproved, 1, 10) #Modify date format
data$dateClosed=substr(data$dateClosed, 1, 10) #Modify date format
data$dateInitiallyApproved=substr(data$dateInitiallyApproved, 1, 10) #Modify date format

write.csv(data,'HazardMitigationAssistanceProjects(cleaned).csv')

##clean_data=na.omit(data)