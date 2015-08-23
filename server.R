library(shiny)
library(ggplot2)
shinyServer(function(input, output) {
  
  output$plot <- renderPlot({
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    a <- read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                      quote=input$quote)
    
    plot(a)
  })
  
  output$summary <- renderPrint({
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    b <- read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                  quote=input$quote)   
    
    summary(b)
  })
  
  output$table <- renderTable({
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header=input$header, sep=input$sep, 
             quote=input$quote)
  })
})



