library(shiny)
library(ggplot2)
library(BlandAltmanLeh)
shinyUI(fluidPage(
  titlePanel("Bland-Altman Plot"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      tags$hr(),
      checkboxInput('header', 'Header', TRUE),
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      radioButtons('quote', 'Quote',
                   c(None='',
                     'Double Quote'='"',
                     'Single Quote'="'"),
                   '"')
      
    ),
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Plot 1", plotOutput("plot1")), 
                  tabPanel("Plot 2", plotOutput("plot2")), 
                  tabPanel("Summary", verbatimTextOutput("summary")), 
                  tabPanel("Table", tableOutput("table"))
      )
    )
  )
))