library(shiny)
library(ggplot2)
library(BlandAltmanLeh)
shinyServer(function(input, output) {
  
  output$plot <- renderPlot({
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    a <- read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                      quote=input$quote)
    ggplot(a, aes(x=HPLC, y=ELISA)) + geom_point()
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



