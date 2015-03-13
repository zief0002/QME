#' Create a test report
#' 
#' This function creates a report with the basic psychometrics
#'
#' @param x An \code{odin_zeus} object
#' @param output The file name of the html report
#' @param open Whether to open the html report
#' @return As a side effect, creates the html report 

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
