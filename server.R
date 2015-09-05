library(shiny)
library(ggplot2)
library(BlandAltmanLeh)
shinyServer(function(input, output) {
  
  datasetInput <- reactive({
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                  quote=input$quote)
  })
  
  output$plot <- renderPlot({
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    a <- read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                      quote=input$quote)
    a[3] <- (a[1]-a[2])
    a[4] <- (a[2]+a[1])/2
    names(a) <- c("a", "b","c","d")
    if (input$radio == 1) {
    bland.altman.plot(a$a, a$b, 
                      xlab="Mean measurement",
                      ylab="Difference")} else {
    g <- bland.altman.plot(a$a, a$b,
         graph.sys="ggplot2")
         print (g + xlab("Mean measurement") + 
         ylab("Difference"))
                      }
  })
  
  output$summary <- renderPrint({
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    a <- read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                  quote=input$quote)
    names(a) <- c("Method1", "Method2")
    bland.altman.stats(a$Method1, a$Method2, 
                       two = 1.96, mode = 2, conf.int = 0.95)
  })
  
  output$table <- renderTable({
    datasetInput()
  })
  output$downloadReport <- downloadHandler(
    filename = function() {
      paste('my-report', sep = '.', switch(
        input$format, PDF = 'pdf', HTML = 'html', Word = 'docx'
      ))
    },
    
    content = function(file) {
      src <- normalizePath('report.Rmd')
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src, 'report.Rmd')
      
      library(rmarkdown)
      out <- render('report.Rmd', switch(
        input$format,
        PDF = pdf_document(), HTML = html_document(), Word = word_document()
      ))
      file.rename(out, file)
    }
  )
})
