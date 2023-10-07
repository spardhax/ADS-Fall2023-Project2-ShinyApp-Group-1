# Project 2
# Spardha Sharma

library(readr)
library(dplyr)
library(ggplot2)
library(sqldf)
library(maps)
library(sf)
library(scales)

# reading the file
data<-read_csv('/Users/Spardha/Downloads/HazardMitigationAssistanceMitigatedProperties_cleaned.csv')

View(data)

# Question 1: How do property actions differ for various mitigation programs? 

# Top 5 property actions per program types
property_actions_vs_program_type <- data %>%
   filter(propertyAction!='Other (Specify in Comments)')%>%
  group_by(programArea, propertyAction) %>%
  summarise(Count = n()) %>%
  arrange(programArea, desc(Count)) %>%
  group_by(programArea) %>%
  mutate(Rank = row_number()) %>%
  filter(Rank <= 5)

View(property_actions_vs_program_type)

unique(property_actions_vs_program_type$programArea)

# Making bar charts for each program area type
# note that this can be an interactive visualization on r shiny with  'programArea' as a filter
ggplot(property_actions_vs_program_type[property_actions_vs_program_type$programArea == "BRIC", ], aes(x = reorder(propertyAction, -Count), y = Count)) +
  geom_bar(stat = "identity", fill="purple") +
  labs(x = "Property Actions", y = "Count") +
  ggtitle("Top 5 Property Actions on BRIC Programs ")+
  theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))

ggplot(property_actions_vs_program_type[property_actions_vs_program_type$programArea == "FMA", ], aes(x = reorder(propertyAction, -Count), y = Count)) +
  geom_bar(stat = "identity", fill="magenta") +
  labs(x = "Property Actions", y = "Count") +
  ggtitle("Top 5 Property Actions on FMA Programs ")+
  theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))

ggplot(property_actions_vs_program_type[property_actions_vs_program_type$programArea == "HMGP", ], aes(x = reorder(propertyAction, -Count), y = Count)) +
  geom_bar(stat = "identity", fill="red") +
  labs(x = "Property Actions", y = "Count") +
  ggtitle("Top 5 Property Actions on HMGP Programs ")+
  theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))

ggplot(property_actions_vs_program_type[property_actions_vs_program_type$programArea == "LPDM", ], aes(x = reorder(propertyAction, -Count), y = Count)) +
  geom_bar(stat = "identity", fill="pink") +
  labs(x = "Property Actions", y = "Count") +
  ggtitle("Top 5 Property Actions on LPDM Programs ")+
  theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))

ggplot(property_actions_vs_program_type[property_actions_vs_program_type$programArea == "PDM", ], aes(x = reorder(propertyAction, -Count), y = Count)) +
  geom_bar(stat = "identity", fill="orange") +
  labs(x = "Property Actions", y = "Count") +
  ggtitle("Top 5 Property Actions on PDM Programs ")+
  theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))

ggplot(property_actions_vs_program_type[property_actions_vs_program_type$programArea == "RFC", ], aes(x = reorder(propertyAction, -Count), y = Count)) +
  geom_bar(stat = "identity", fill="dark green") +
  labs(x = "Property Actions", y = "Count") +
  ggtitle("Top 5 Property Actions on RFC Programs ")+
  theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))

ggplot(property_actions_vs_program_type[property_actions_vs_program_type$programArea == "SRL", ], aes(x = reorder(propertyAction, -Count), y = Count)) +
  geom_bar(stat = "identity", fill="blue") +
  labs(x = "Property Actions", y = "Count") +
  ggtitle("Top 5 Property Actions on SRL Programs ")+
  theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))

# making a heatmap to get an overview of program types v/s property actions

percentage_data<- data %>%
  filter(propertyAction != 'Other (Specify in Comments)') %>%
  group_by(programArea, propertyAction) %>%
  summarise(Count = n()) %>%
  group_by(programArea) %>%
  mutate(TotalCount = sum(Count),
         Percentage = (Count / TotalCount) * 100) %>%
  select(programArea, propertyAction, Percentage)

percentage_data

ggplot(percentage_data, aes(x = propertyAction, y = programArea, fill = Percentage)) +
  geom_tile() +
  scale_fill_viridis_c(direction = -1) +  # You can change the color scale as needed
  labs(x = "Program Area", y = "Property Action", fill = "Percentage") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Question 2: How do building structure types differ for various mitigation programs? 

property_actions_vs_structure_type <- data %>%
  filter(structureType!='Other (Specify in Comments)')%>%
  group_by(programArea, structureType) %>%
  summarise(Count = n()) %>%
  arrange(programArea, desc(Count)) %>%
  group_by(programArea) %>%
  mutate(Rank = row_number()) %>%
  filter(Rank <= 5)


# Making bar charts for each program area type
# note that this can be an interactive visualization on r shiny with  'programArea' as a filter
ggplot(property_actions_vs_structure_type[property_actions_vs_structure_type$programArea == "BRIC", ], aes(x = reorder(structureType, -Count), y = Count)) +
  geom_bar(stat = "identity", fill="purple") +
  labs(x = "Structure Type", y = "Count") +
  ggtitle("Top 5 Structure Types of BRIC Programs")+
  theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))

ggplot(property_actions_vs_structure_type[property_actions_vs_structure_type$programArea == "FMA", ], aes(x = reorder(structureType, -Count), y = Count)) +
  geom_bar(stat = "identity", fill="magenta") +
  labs(x = "Structure Type", y = "Count") +
  ggtitle("Top 5 Structure Types of FMA Programs")+
  theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))

ggplot(property_actions_vs_structure_type[property_actions_vs_structure_type$programArea == "HMGP", ], aes(x = reorder(structureType, -Count), y = Count)) +
  geom_bar(stat = "identity", fill="red") +
  labs(x = "Structure Type", y = "Count") +
  ggtitle("Top 5 Structure Types of HMGP Programs")+
  theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))

ggplot(property_actions_vs_structure_type[property_actions_vs_structure_type$programArea == "LPDM", ], aes(x = reorder(structureType, -Count), y = Count)) +
  geom_bar(stat = "identity", fill="pink") +
  labs(x = "Structure Type", y = "Count") +
  ggtitle("Top 5 Structure Types of LPDM Programs ")+
  theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))

ggplot(property_actions_vs_structure_type[property_actions_vs_structure_type$programArea == "PDM", ], aes(x = reorder(structureType, -Count), y = Count)) +
  geom_bar(stat = "identity", fill="orange") +
  labs(x = "Structure Type", y = "Count") +
  ggtitle("Top 5 Structure Types of PDM Programs")+
  theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))

ggplot(property_actions_vs_structure_type[property_actions_vs_structure_type$programArea == "RFC", ], aes(x = reorder(structureType, -Count), y = Count)) +
  geom_bar(stat = "identity", fill="dark green") +
  labs(x = "Structure Type", y = "Count") +
  ggtitle("Top 5 Structure Types of RFC Programs")+
  theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))

ggplot(property_actions_vs_structure_type[property_actions_vs_structure_type$programArea == "SRL", ], aes(x = reorder(structureType, -Count), y = Count)) +
  geom_bar(stat = "identity", fill="blue") +
  labs(x = "Structure Type", y = "Count") +
  ggtitle("Top 5 Structure Types of SRL Programs")+
  theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))

structure_type_data<- data %>%
  filter(structureType != 'Other (Specify in Comments)') %>%
  group_by(structureType) %>%
  summarise(Count = n()) %>%
  mutate(TotalCount = sum(Count),
         Percentage = (Count / TotalCount) * 100)

# Creating a pie chart that gives an overview of the most common structure types
ggplot(structure_type_data, aes(x = "", y = Percentage, fill = structureType)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  theme_void() +
  theme(legend.position = "bottom")

# Question 3: Which foundation types are found in most properties that are expected to be mitigated?

foundations <- data %>%
  filter(foundationType!='Other (Specify in Comments)')%>%
  group_by(foundationType) %>%
  summarise(total_amount = sum(actualAmountPaid, na.rm = TRUE))


foundations$foundationType <- factor(foundations$foundationType, levels = foundations$foundationType[order(-foundations$total_amount)])

ggplot(foundations, aes( x = total_amount, y = foundationType)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(x = NULL, x = "Total Amount in Millions", y = "Foundation Type") +
  theme_minimal()+
  scale_x_continuous(labels = scales::comma_format(scale = 1e-6, accuracy = 1))+
  theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))

# Question 4: Which states have the most properties that are expected to be mitigated?

state_data<- data %>%
  group_by(state) %>%
  summarise(total_amount = sum(actualAmountPaid, na.rm = TRUE))

temp <- sqldf('SELECT LOWER(state) as state, total_amount FROM state_data')
state_map <- map_data("state")

merged <- sqldf('SELECT state.*, temp.total_amount FROM temp AS temp INNER JOIN state_map AS state ON temp.state = state.region')

# note this can be an interactive map on r shiny 
ggplot(merged, aes(x = long, y = lat, group = group, fill = total_amount)) +
  geom_polygon() +
  scale_fill_gradient(low = "yellow", high = "red") +
  labs(title = "Statewise Concentration of Mitigated Properties") +
  theme_minimal()

# Question 5: How has the average actual amount amount paid to the property owner for mitigation efforts changed over the years?

# note this can be an interactive time series plot on r shiny with various filters like state, programArea, structureType etc

average_funding_per_year <- data %>%
  group_by(programFy) %>%
  summarise(average_amount = mean(actualAmountPaid, na.rm = TRUE))

# filtering out rows with missing average_amount
filtered_funding_per_year <- average_funding_per_year[!is.na(average_funding_per_year$average_amount),]

# Plotting the time series without missing values
ggplot(filtered_funding_per_year, aes(x = programFy, y = average_amount)) +
  geom_line() +
  labs(x = "Year", y = "Average Actual Amount Paid", title = "Average Funding Received by Tenant Per Year") +
  theme_minimal()