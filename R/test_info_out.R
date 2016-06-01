#' Outputs basic test-level information
#' 
#' Ouputs histogram or dotplot of test score distribution and test-level descriptives in a table.
#'
#' @param x An \code{analyze} object
#' @param plot Plot the test score distribution?
#' 
#' @return
#' A ggplot2 histogram or dotplot of the test score distribution and a Markdown table
#' with the minimum, maximum, mean, and median test score as well as the standard deviation,
#' IQR, skewness, and kurtosis of the score distribution.
#' 
#' @details
#' Person total scores from the \code{\link{analyze}} object are extracted and the distribution
#' of scores is plotted as a side-effect.  If the number of persons is >= 50, the frequency distribution
#' of scores is presented with a histogram with binwidth = 1.  If the number of persons is
#' < 50, a dotplot is produced.
#' 
#' Test-level descriptives are extracted from the \code{\link{analyze}} object and returned in a markdown
#' table; this is currently used by the \code{\link{report}} function.
#' 
#' @export
#
test_info_out = function(x, plot = TRUE) {

  if(plot)
    plot(getQMEtest(x))
  
  knitr::kable(test_summary_matrix(x$test_level$descriptives), digits = 2, align = "c")
}


