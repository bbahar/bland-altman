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
      radioButtons('sep', 'Data Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      radioButtons('quote', 'Quote',
                   c(None='',
                     'Double Quote'='"',
                     'Single Quote'="'"),
                   '"'),
      tags$hr(), 
      radioButtons('radio', 'Select Plot Type',
                   choices = list("Base"= 1,
                                  "ggplot2"= 2))
    ),
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Selected Plot", plotOutput("plot1")), 
#                 tabPanel("BA 2 (ggplot)", plotOutput("plot2")), 
                  tabPanel("BA Statistics", verbatimTextOutput("summary")), 
                  tabPanel("Data", tableOutput("table"))
      )
    )
  )
))