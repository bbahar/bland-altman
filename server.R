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
    
    M1 <- input$Method1
    M2 <- input$Method2
    
    colnames(a)[1] <- M1
    colnames(a)[2] <- M2
    
    M1 <- input$Method1
    M2 <- input$Method2
    plot(x=a$M1,y=a$M2)
#    ggplot(a, aes(x=(a$M1+a$M2)/2, y=(a$M1-a$M2)/2)) + 
#    geom_point() +
#    labs(x='Method Mean',y='Method Difference')
  })
  
  output$summary <- renderPrint({
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    b <- read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                  quote=input$quote)   
    
    bland.altman.stats(b$Method1, b$Method2, 
                       two = 1.96, mode = 2, conf.int = 0.95)
  })
  
  output$table <- renderTable({
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header=input$header, sep=input$sep, 
             quote=input$quote)
  })
  
  output$Data <- renderText({
    
    paste(input$Method1, "vs.", input$Method2)
    
  })
  
})
