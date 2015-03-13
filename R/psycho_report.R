psycho_report = function(x, output = "output.html", open = TRUE) {
  ## Inputs an odin_zeus, creates report, returns filename
  thistest = x
  
  template = system.file("report_templates/ctt_template.Rmd",
                         package = "QME")
  
  knit2html(template, output)
  
  ## open it
  if(open) {
    print(output)
    browseURL(paste0('file://', file.path(getwd(), output)))
  } 
    
  
}
