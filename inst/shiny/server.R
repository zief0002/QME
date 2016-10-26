shinyServer(function(input, output) {
  originalFileInput <- reactive({
    in.file <- input$file1
    
    if (is.null(in.file))
      return(NULL)
    
    if (input$rownames) {
      read.table(in.file$datapath, header=input$header, sep=input$sep,
                 quote=input$quote, row.names=1)
    } else {
      read.table(in.file$datapath, header=input$header, sep=input$sep,
                 quote=input$quote)
    }
  })

  
  keyFileInput <- reactive({
    key.file <- input$file2
    
    if (is.null(key.file))
      return(NULL)
    
    # if (input$rownames1) {
    #   read.table(key.file$datapath, header=input$header1, sep=input$sep1,
    #              quote=input$quote1, row.names=input$rownames1)
    # } 
    else {
      read.table(key.file$datapath, header=input$header1, sep=input$sep1, quote=input$quote1)
    }
  })
  
  analysis1 <- reactive({
    test <- originalFileInput()
    key <- keyFileInput()
    if (is.null(test)|is.null(key))
      return(NULL)
    
    if (input$rownames) {
      analyze(test=test, key=key, id=FALSE)
    }  else {analyze(test = test,key = key)
      }
  })
  
  output$datafile <- renderTable({
    head(originalFileInput(), n=10)  
  })
  
  output$key <- renderTable({
    head(keyFileInput(), n=10)  
  })
  
  output$knit_doc <- renderPrint({

      capture.output(
      md <- isolate(tryCatch(
        suppressMessages(
          suppressWarnings(
           psycho_report(analysis1(), quiet = TRUE, simple_html = TRUE))),
        error = function(e) {FALSE}))
    )
    if(exists("md")) {
      if(md == FALSE)
        out = "Rendering..."
      else
        out = HTML(md)
    }
    else
      out = "Rendering..."
    
    return(out)
  })
  

  
})
