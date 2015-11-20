library(shiny)
library(mcr)
library(shinydashboard)
library(rhandsontable)

dashboardPage(
  dashboardHeader(title = "Method Comparison"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Information", tabName = "info", 
               icon = icon("info", "fa-lg")),
      #       menuItem("Data Entry", tabName = "dataentry", 
      #                icon = icon("upload", "fa-lg")),
      menuItem("Data", tabName = "data", 
               icon = icon("table", "fa-lg")),
      #       menuItem("Method Selection", tabName = "dataopt",
      #                icon = icon("random", "fa-lg")),
      menuItem("Plots", tabName = "plots",
               icon = icon("line-chart", "fa-lg"),
               menuSubItem("BA Plot", tabName = "subitem1"),
               menuSubItem("Scatter Plot", tabName = "subitem2")),
      menuItem("Statistics", tabName = "stats",
               icon = icon("users", "fa-lg")),
      menuItem("Download", tabName = "download",
               icon = icon("download", "fa-lg"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "info",
              h2("Method Comparison Using R and Shiny"),
              br(),
              h4('This website is a product of R programming language (1) and 
                 shiny web application framework (2). Statistics are based on mcr package (3).'),     
              br(),
              h4('How to:'),
              h4('1. Copy/paste or enter your data using the "Data" tab and 
                 enter method names.'),
              h4('2. See your data distribution and choose statistical tests using the "Plots" tab.'),
              h4('3. See the statistical evaluation of the selected data using the "Statistics" tab and 
                 download using the "Download" tab.'),
              br(),
              h4('References and packages:'),
              h5("1. R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL https://www.R-project.org/."),
              h5("2. shiny: Web Application Framework for R. R package version 0.12.2. URL http://CRAN.R-project.org/package=shiny/."),
              h5("3. mcr: Method Comparison Regression. R package version 1.2.1. URL http://CRAN.R-project.org/package=mcr/."),
              h5("4. shinydashboard: Create Dashboards with 'Shiny'. R package version 0.5.1. URL http://rstudio.github.io/shinydashboard/."),
              h5("5. rhandsontable: Interface to the 'Handsontable.js' Library. R package version 0.2.1. URL http://jrowen.github.io/rhandsontable/.")
              ),
      #       tabItem(tabName = "dataentry",
      #               fileInput('file1', h5('Choose CSV File'),
      #                         accept=c('text/csv', 
      #                                  'text/comma-separated-values,text/plain', 
      #                                  '.csv')),
      #               checkboxInput('header', 'Header', TRUE),
      #               radioButtons('sep', h5('Data Separator'),
      #                            c(Comma=',',
      #                              Semicolon=';',
      #                              Tab='\t'),
      #                            ','),
      #               radioButtons('quote', h5('Quote'),
      #                            c(None='',
      #                              'Double Quote' = '"',
      #                              'Single Quote' = "'"),
      #                            '"')),
      #       tabItem(tabName = "dataopt",
      #               fixedRow(
      #                 column(6,htmlOutput('varselect')),
      #                 column(6,htmlOutput('varselect2')))
      #       ),
      tabItem(tabName = "data",
              box(title = "Enter Data", status = 'info',
                  rHandsontableOutput("hot")),
              box(title = 'Enter Method Names', status = 'info',
                  textInput('m1', label = h4('Reference Method'),
                            value = 'Method 1'),
                  textInput('m2', label = h4('Test Method'),
                            value = 'Method 2'))
      ),
      tabItem(tabName = "subitem1",
              box(title = "Bland-Altman Plot", status='info', 
                  plotOutput("plot1")),
              box(title = "Bland-Altman Options", status='info',
                  selectInput('batype', h5('Bland-Altman Plot Type'), 
                              choices=list('0.5*(X+Y) vs. Y-X' = 3,
                                           'X vs. Y-X' = 1,
                                           'X vs. (Y-X)/X' = 2,
                                           '0.5*(X+Y) vs. (Y-X)/X' = 4,
                                           'rank(X) vs. Y-X' = 5,
                                           'rank(X) vs. (Y-X)/X' = 6,
                                           'sqrt(X*Y) vs. Y/X' = 7,
                                           '0.5*(X+Y) vs. (Y-X) / (0.5*(X+Y))' = 8)))
      ),
      tabItem(tabName = "subitem2",
              box(title = "Scatter Plot", status='info',
                  plotOutput("plot2"),
                  verbatimTextOutput("info2")),
              box(title = "Scatter Plot Options", status='info',
                  selectInput('regmodel', h5('Regression Model'), 
                              choices=list('Ordinary Least Square' = 'LinReg',
                                           'Weighted Ordinary Least Square' = 'WLinReg',
                                           'Deming' = 'Deming',
                                           'Weighted Deming' = 'WDeming',
                                           'Passing-Bablok' = 'PaBa',
                                           'Passing-Bablok Large Data' = 'PaBaLarge')),
                  fixedRow(
                    column(6, selectInput('cimethod', h5('CI Method'), 
                                          choices=list('Analytical' = 'analytical',
                                                       'Jacknife' = 'jackknife',
                                                       'Bootstrap' = 'bootstrap',
                                                       'Nested Bootstrap' = 'nestedbootstrap'))),
                    
                    column(6, selectInput('metbootci',h5('Bootstrap CI Method'),
                                          choices = list('Quantile'='quantile',
                                                         'Student'='Student',
                                                         'BCa'='BCa',
                                                         'tBoot'='tBoot')))
                  ),
                  fixedRow(
                    column(6, selectInput('cormet',h5('Correlation Method'),
                                          choices = list('Pearson'='pearson',
                                                         'Kendall'='kendall',
                                                         'Spearman'='spearman')
                    )),
                    column(6, numericInput('syx', h5('Sy/Sx'), value=1))
                  ),
                  fixedRow(
                    column(6,  
                           checkboxInput('identity', 'Add identity line', value = TRUE),
                           checkboxInput('ciarea', 'Add CI Area', value = TRUE)),
                    column(6,
                           checkboxInput('legend', 'Add Legend', value = TRUE),
                           checkboxInput('addcor', 'Add Correlation',value = TRUE))))
      ),
      tabItem(tabName = "stats",
              verbatimTextOutput("summary")
      ),
      tabItem(tabName = "download",
              radioButtons('format', h5('Document format'), 
                           c('PDF','HTML', 'Word'),
                           inline = TRUE),
              downloadButton('downloadReport')
      )
              )
  )
  )
