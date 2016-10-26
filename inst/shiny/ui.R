
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(QME)

shinyUI(fluidPage(
  sidebarPanel(
    fileInput('file1', 'Bring in CSV File',
              accept=c('text/csv', 'text/comma-separated-values,text/plain')),
    fileInput('file2', 'Bring in CSV key File',
              accept=c('text/csv', 'text/comma-separated-values,text/plain')),
    tags$hr(),
    checkboxInput('rownames', 'Data ID Column', TRUE)
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Data",
              br(),
               br(),br(),
               tableOutput('datafile')
      ),
      tabPanel("Key",
               br(),
               br(),br(),
               tableOutput('key')
               
      ),
      tabPanel("Summary",
               br(),
               htmlOutput("knit_doc"),
               br()
               
      )
    )
  )
)

)
