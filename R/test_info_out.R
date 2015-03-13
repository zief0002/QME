test_info_out = function(x) {
  ## Ouputs histogram or dotplot of test score distribution
  ## and test level descriptives in a table:  # of items, # examinees, moments
  
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


