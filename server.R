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

    ggplot(a, aes_string(colnames(a)[1],y=colnames(a)[2])) +
    geom_point() +
    labs(x='Method Mean',y='Method Difference')
  })
  
  output$summary <- renderPrint({
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    b <- read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                  quote=input$quote)   

    bland.altman.stats(b$b1, b$b2, 
                       two = 1.96, mode = 2, conf.int = 0.95)
  })
  
  output$table <- renderTable({
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header=input$header, sep=input$sep, 
             quote=input$quote)
  })
  
})
