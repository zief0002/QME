#' Outputs basic test-level information
#' 
#' Ouputs histogram or dotplot of test score distribution and test-level descriptives in a table.
#'
#'@param x An \code{odin_zeus} object
#'
#'@return
#'A ggplot2 histogram or dotplot of the test score distribution and a Markdown table
#'with the minimum, maximum, mean, and median test score as well as the standard deviation,
#'IQR, skewness, and kurtosis of the score distribution.
#'
#'@details
#'Person total scores from the \code{odin_zeus} object are extracted and the distribution
#'of scores is plotted.  If the number of persons is >= 50, the frequency distribution
#'of scores is presented with a histogram with binwidth = 1.  If the number of persons is
#'< 50, a dotplot is produced.
#'
#'Test-level descriptives are extracted from the \code{odin_zeus} object and outputted in a markdown
#'table that can then be rendered with \code{psycho_report}.
#
test_info_out = function(x) {

  ## Extracts scores from oz
  scores = data.frame(scores = x$test_level$descriptives$scores)
  
  ## If >= 50 examinees, distribution of scores presented with a histogram.  If less than 50,
  ## a dotplot is produced
  if(length(scores$scores) >= 50){
    
    scoreplot = ggplot(scores, aes(scores)) + 
                geom_histogram(binwidth = 1) + 
                xlab("Total score") + ylab("# of students") +
                theme_bw() + ggtitle("Distribution of total scores")
  } else {
    
    scoreplot = ggplot(scores, aes(scores)) +
                geom_dotplot() + 
                xlab("Total score") + ylab("Proportion of students") +
                theme_bw() + ggtitle("Distribution of total scores")
  }
  
  ## Test level descriptives are extracted from oz, row and column names are added, then
  ## then converted to a matrix
  tinfo = x$test_level$descriptives[c("min_score","max_score", "mean_score","median_score",
                                      "sd_score","iqr_score", "skew_score",
                                      "kurtosis_score")]
  tinfo2 = data.frame(as.numeric(tinfo))
  rownames(tinfo2) = c("Minimum Score","Maximum Score", "Mean Score","Median Score",
                       "Standard Deviation","IQR", "Skewness (G1)",
                       "Kurtosis (G2)")
  colnames(tinfo2) = "Value"
  tinfo2 = as.matrix(tinfo2)
  
  print(scoreplot)
  return(knitr::kable(tinfo2, digits = 2, align = "c"))
}


