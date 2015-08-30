library(shiny)
library(ggplot2)
library(BlandAltmanLeh)
shinyServer(function(input, output) {
  
  output$plot1 <- renderPlot({

    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    a <- read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                      quote=input$quote)
    a[3] <- (a[2]-a[1])
    a[4] <- (a[2]+a[1])/2
    names(a) <- c("a", "b","c","d")
    ggplot(a, aes_string(x=colnames(a)[4],y=colnames(a)[3])) +
    geom_point() +
    labs(x='Method Mean',y='Method Difference')
  })
  output$plot2 <- renderPlot({
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    a <- read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                  quote=input$quote)
    a[3] <- (a[2]-a[1])
    a[4] <- (a[2]+a[1])/2
    names(a) <- c("a", "b","c","d")
    bland.altman.plot(a$a, a$b, xlab="Mean measurement",
                      ylab="Differences", conf.int=.95)
  })
  output$summary <- renderPrint({
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    b <- read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                  quote=input$quote)   
    names(b) <- c("Method1", "Method2")
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
  
})
