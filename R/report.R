#' Create a test report
#' 
#' This function creates a report with the basic psychometrics
#' 
#' This reports contains number of items, number of examinees, a distribution of
#' the total scores, reliability estimates (Coefficient Alpha, Guttman's L2, 
#' Guttman's L4, Feldt-Gilmer, and Feldt-Brennan), item overview (difficulty, 
#' point-biserial correlation, corrected point-biserial correlation, number of 
#' missing responses, and probability of missing responses), and distractor analysis.
#' 
#' Rendering is done by means of \code{\link{render}} from the \code{rmarkdown}
#' package.  See that help page for more details on the rendering process.
#' 
#' @param x An \code{analyze} object
#' @param report_filename The file name of the report (not including file extension, which is determined automatically)
#' @param output_format One of \code{"html_document"}, \code{"word_document"},
#'   or \code{"pdf_document"}.  Note that \code{'pdf_document'} requires a
#'   working LaTeX implementation.
#' @param output_dir The path to the directory that the report will be written to.  If NULL, written to current working directory.
#' @param simple_html If \code{TRUE}, overrides \code{output_format} and outputs a character object containing a simple (R Markdown v1) html report, useful for embedding in Shiny apps.
#' @param ... passed to \code{\link{render}}
#' @return If \code{simple_html = FALSE}, the default, generates report file as a side effect.  If \code{simple_html = TRUE}, returns a string with the html of the report.
#' @aliases psycho_report
#' @export

report = function(x, report_filename = "QME_report", output_format = "html_document", output_dir = NULL, simple_html = FALSE, ...) {
  ## Inputs an analyze, creates report, returns filename
  thistest = x
  
  ## Set up filenames for render to work nicely
  if(is.null(output_dir))
    output_dir = getwd()
  
  old_dir = setwd(output_dir)
  
  template = system.file("report_templates/ctt_template.Rmd",
                         package = "QME")
  input_file = paste0(report_filename, ".Rmd")
  
  file.copy(from = template, to = input_file, overwrite = TRUE)
  
  if(simple_html) {
    html_output = knitr::knit2html(input_file, quiet = TRUE, force_v1 = TRUE)
    output = readr::read_file(html_output)
    unlink(paste0(report_filename, c(".md", ".html")))
  } else {
    
    output = rmarkdown::render(input_file, output_format = output_format, output_dir = output_dir, ...)
  }
 
  unlink(input_file)
  setwd(old_dir)
  
  output
  
}

#' @export 
psycho_report = report
