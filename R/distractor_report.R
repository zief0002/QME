#' Distractor report
#' 
#' Outputs distractor analysis and plots for \code{\link{analyze}} objects, intended to be used within \code{rmarkdown} documents
#' 
#' For each item, produces distractor plots and a table showing distractor performance.
#' 
#' @param x An \code{\link{analyze}} object
#' @return As a side effect, prints distractor plots and distractor tables
#' @export
distractor_report = function(x) {
  if(!hasKey(x$test)) {
    cat("Raw test was not provided, so distractor analysis is not available.\n")
  } else {
    
    terciles = getTerciles(x)
    
    for(i in 1:length(item_names(x))) {
      
      cat("### Details for `", item_names(x)[i])
      cat("`\n\n")
      
      
      cat("\n\n\n")
      
      
      print(tercile_plot(terciles[[i]]))
      
      
      cat("\n\n")
      
      cat(knitr::kable(x$item_level$distractor_analysis[[i]], digits = 2), sep = "\n")
      
      cat("\n\n")
      
    }
  }
}