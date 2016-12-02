#' Open QME shiny app
#' 
#' Opens a Shiny app to generate reports
#' 
#' @return As a side effect, runs and opens the QME shiny application.
#' @import readr
#' @import shiny
#' @export
QME_shiny <- function() {
  ## Adapted from Dean Attali: http://deanattali.com/2015/04/21/r-package-shiny-app/
  appDir <- system.file("shiny", package = "QME")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `QME`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}