# Libraries
library(shiny)
library(arules)
library(tidyverse)
library(arulesViz)
library(visNetwork)
library(shinydashboard)
library(shinyWidgets)

# Loading in the dataset
surveydata <- read.csv("surveydata.csv", stringsAsFactors = TRUE, header = TRUE)

# Removing ID column
surveydata <- surveydata[, -1]

# Making column names more descriptive
colnames(surveydata) <- c("Q1: Gender", "Q2: Age-group", "Q3: Country", 
                          "Q4: Education", "Q5: Major", "Q6: Job Title",
                          "Q9: Annual Income", "Q12: Preferred analysis software", 
                          "Q17: Preferred programming language", "Q18: Recommended language for a data scientist",
                          "Q20: Preferred machine learning library", "Q22: Preferred visualization library", 
                          "Q23: Time spent coding", "Q25: Machine learning experience", "Q26: Identify as a data-scientist",
                          "Q32: Data type typically worked with", "Q37: Preferred online data science resource", 
                          "Q39: Online courses vs traditional")

# UI
ui <- dashboardPage(
  dashboardHeader(title = "Association Rules",
  tags$li(actionLink("openModal", label = "", icon = icon("info")),
          class = "dropdown")
),
dashboardSidebar(
  # Output menu
  sidebarMenu(
    menuItem("Rules Graph", tabName = "rulesgraph"),
    menuItem("Rules DataTable", tabName = "rulestbl")
  ),
  sidebarUserPanel("APRIORI Algorithm Parameters"),
# Input of rule support
  sliderInput("supportinput", "Support:", min = 0, max = 1, 
               step = 0.001, value = 0.2),
 
# Input of rule confidence level
      sliderInput("confinterval", "Confidence:",
                             min = 0, max = 1,
                  step = 0.05, value = 0.7),
# Input of min len
  sliderInput("minlen", "Minimum Itemset Length:",
              min = 1, max = 10,
              step = 1, value = 2),
# Input of max len
  sliderInput("maxlen", "Maximum Itemset Length:",
              min = 1, max = 10,
              step = 1, value = 4),
# Option to remove redundant rules 
checkboxInput("rrules","Remove Redundant Rules", value = FALSE),
textOutput("textcheck")

),
# Configuring tabs for graph and datatable
dashboardBody(
  tabItems(
    tabItem("rulesgraph",
            fluidRow(
              box(width = 12,
                visNetworkOutput('rulesgraph', height = '700')
              )
            )
    ),
    tabItem("rulestbl",
            # Download button for rules table
            downloadButton("downloadrules", "Download as CSV"),
            DT::dataTableOutput('rulestbl')
    )
  )
)
)


# Server
server <- function(input, output) {
  

  # Running the APRIORI algorithm
rules <- reactive(
  {

   apriori(surveydata, parameter = list(support = input$supportinput,
                                       confidence = input$confinterval,
                                      minlen = input$minlen, maxlen = input$maxlen))

    }
  )



#Output message if checkbox is checked of number of rules removed
output$textcheck <- renderText( {

   if(input$rrules) {
   print(paste("Number of rules removed:", sum(is.redundant(rules()))))
   }

}
)


# Output for interactive graph
output$rulesgraph <- renderVisNetwork({

  rules_dat <- rules()

  # Removing redundant rules if checkbox is ticked
  if(input$rrules) {
    print(paste("Removed", sum(is.redundant(rules_dat)), "rules"))
    rules_dat <- rules_dat[!is.redundant(rules_dat)]
  } else {
    rules_dat
  }


  vis_graph <- plot(rules_dat, method = "graph", engine = "html")

  vis_graph

})

# Output for datatable
output$rulestbl <- DT::renderDataTable( {

  rules_dat <- rules()

  # Removing redundant rules if checkbox is ticked
  if(input$rrules) {
    print(paste("Removed", sum(is.redundant(rules_dat)), "rules"))
    rules_dat <- rules_dat[!is.redundant(rules_dat)]
  } else {
    rules_dat
  }


  rulesdf <- as(rules_dat, 'data.frame')

  rulesdf

})

# Output for downloading rules as CSV
output$downloadrules <- downloadHandler(
  filename = 'kaggle_2017_rules.csv',
  content = function(file) {
    write.csv(as(rules(), 'data.frame'), file)
  }
)

# Header information output
observeEvent(input$openModal, {
  showModal(
    modalDialog(title = "Welcome!",
                p("This is an app to explore a subset of responses to the industry-wide Machine Learning and 
  Data Science Survey administered by Kaggle in 2017 through association rule learning. Association 
  Rule learning is a text-mining technique that can conveniently construct sets of items which 
  frequently co-occur together in a dataset. Play with the sliders to control the APRIORI algorithm 
                                parameters, and the interactive outputs to understand the rules generated."))
  )
})

}

shinyApp(ui = ui, server = server)