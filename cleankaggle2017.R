######### Exploring survey data for shiny app #############
# Loading packages
library(arules)
library(tidyverse)
library(arulesViz)

surveydata <- read.csv("multipleChoiceResponses.csv", 
                       stringsAsFactors = TRUE, header = TRUE)

# Removing the first row
surveydata <- surveydata[-1, ]

# Keep rows we care about 
surveydata <- surveydata[, c(2, 4, 5, 6, 7, 8, 13, 23, 85, 87, 109, 125, 127,
                              129, 130, 264,
                              305, 306, 331, 373)]

# Writing csv file
write.csv(surveydata, file = "surveydata.csv")