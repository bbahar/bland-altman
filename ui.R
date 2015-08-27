library(shiny)
library(ggplot2)
library(BlandAltmanLeh)
shinyUI(fluidPage(
  titlePanel("Uploading Files for Bland-Altman Plots"),
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
                   '"'),
      textInput('Method1',label = 'Enter Method 1 Name', value = 'Method1'),
      textInput('Method2',label = 'Enter Method 2 Name', value = 'Method2')
      
    ),
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Plot", plotOutput("plot")), 
                  tabPanel("Summary", verbatimTextOutput("summary")), 
                  tabPanel("Table", tableOutput("table")),
                  tabPanel("Data",textOutput("Data"))
      )
    )
  )
))