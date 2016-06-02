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
      
      choices = rownames(x$item_level$distractor_analysis[[1]][[i]])
      keys = x$test$key[match(choices, x$test$key$response), 1 + i]
      
      tbOut = data.frame(Choice = choices,
                         Key = keys,
                         Proportions = as.numeric(x$item_level$distractor_analysis[[1]][[i]]),
                         `Response Discrimination` = as.numeric(x$item_level$distractor_analysis[[2]][[i]]),
                         check.names = FALSE
      )
      print(knitr::kable(tbOut, digits = 2))
      
      cat("\n\n")
      
    }
  }
}