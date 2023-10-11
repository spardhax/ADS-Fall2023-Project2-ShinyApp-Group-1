# Project 2: Shiny App Development

### [Project Description](doc/project2_desc.md)

Term: Fall 2023

![screenshot](doc/figs/map.jpg)

In this second project of GR5243 Applied Data Science, we develop a *Exploratory Data Analysis and Visualization* shiny app using one of **the OpenFEMA data sets** of our choice. See [Project 2 Description](doc/project2_desc.md) for more details.  

The **learning goals** for this project is:

- business intelligence for data science
- data cleaning
- data visualization
- systems development/design life cycle
- shiny app/shiny server

##  Exploring Property Actions & Funding in Hazard Mitigation Projects in the US

[R Shiny App Link](https://dtdluce.shinyapps.io/FEMA_Hazard_Mitigation/)

Term: Fall 2023
+ Team #1
+ Team members:
	+ Spardha Sharma (ss6343)
	+ Daniel Thomas Luce (dtl2129)
	+ Lia Cho (lc3683)
	+ Feiyu Guo (fg2545)
	+ Chencan Zou (cz2675)
 	+ Puqi Song (ps3387)

+ **Project summary**: We examined data from [Hazard Mitigation Assistance Projects](https://www.fema.gov/openfema-data-page/hazard-mitigation-assistance-projects-v3) & [Hazard Mitigation Assistance Mitigated Properties](https://www.fema.gov/openfema-data-page/hazard-mitigation-assistance-mitigated-properties-v3). Our objective was to learn about the property actions taken in the US of hazard mitigation projects. We looked at how these actions vary based on the type of hazard (floods/earthquakes/etc.) and housing structure (residential/commercial/etc.). Additionally, we analyzed funding trends over the years and predicted changes in the number of projects. We also conducted a detailed state-wise analysis to gain localized insights. Our analysis aims to answer the following questions:

  + How do property actions differ for various mitigation programs? 
  + How do building structure types differ for various mitigation programs?
  + Which states have received the most funding on mitigation programs?
  + How has the median actual amount amount paid to the property owner for mitigation efforts changed over the years?
  + How will the number of mitigation projects change over the next 3 years?
  + How does the number of mitigation programs vary across different states?
  + How has the number of mitigation programs changed over the years?
  + How are property actions distributed?

+ **Contribution statement**: All members helped outline the app development process and goals.
PS and CZ cleaned and organized the source data. SS created a map visualization, FEMA program
breakdowns by property actions and structure types, and established baseline code for the median
funding by state and year. LC produced a map visualization and projects by property action
graphics. PS also executed and visualized the two future predictions. SS also formulated the
business questions and project summary after looking at all data files. DL broke down the median funding by year to the
state level and prepared each visualization for Shiny App use by creating RDS objects.
DL and FG wrote the codes for the Shiny widgets and DL organized them into the singular Shiny App.
DL reconfigured the documents to successfully export to shinyapps.io. SS, DL, and PS edited the ReadMe files, and LC proofread these files.

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is organized as follows.

```
proj/
├── app/
├── data/
├── doc/
    ├── fig/
├── lib/

```

Please see each subfolder for a README file.

