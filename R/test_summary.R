# This function computes total scores for the respondents and then computes summary measures

test_summary_list = function(QMEtest) {
  responses = getKeyedTestNoID(QMEtest)
  
  # Get the total scores for each student (row) summary
  scores = getTotalScores(QMEtest)
  
  
  # Compute type 2 skewness (G1; used in SPSS and SAS)
  # Adapted from the e1071 library
  n = length(scores)
  dev = scores - mean(scores)
  y = sqrt(n) * sum(dev ^ 3) / (sum(dev ^ 2) ^ (3 / 2))
  g1 = y * sqrt(n * (n - 1)) / (n - 2)
  
  # Compute type 2 kurtosis (G2; used in SPSS and SAS)
  # Adapted from the e1071 library
  n = length(scores)
  dev = scores - mean(scores)
  r = n * sum(dev ^ 4) / (sum(dev ^ 2) ^ 2)
  g2 = ((n + 1) * (r - 3) + 6) * (n - 1) / ((n - 2) * (n - 3))
  
  # Compute the number of students with each total score
  freqs = data.frame(
    score = as.numeric(names(table(scores))),
    frequency = as.numeric(table(scores))
  )
  
  # Compute the proportion of students with each total score
  props = data.frame(
    score = as.numeric(names(table(scores))),
    frequency = as.numeric(table(scores))
  )
  props$proportion = props$frequency / length(scores)
  
  props = props[ , c("score", "proportion")]
  
  
  # Compute summary measure for total scores
  summary_scores = list(
    number_items = ncol(responses),
    number_examinees = nrow(responses),
    scores = scores,
    mean_score = mean(scores),
    median_score = median(scores),
    sd_score = sd(scores),
    iqr_score = IQR(scores),
    min_score = min(scores),
    max_score = max(scores),
    skew_score = g1,
    kurtosis_score = g2,
    frequency_score = freqs,
    proportion_score = props
  )
  
  return(summary_scores)
  
}

## Take summary matrix and refine to summary list
test_summary_matrix = function(summary_list) {
  ## Test level descriptives are extracted from analyze object, row and column
  ## names are added, then then converted to a matrix
  tinfo = summary_list[c("min_score","max_score", "mean_score","median_score",
                                      "sd_score","iqr_score", "skew_score",
                                      "kurtosis_score")]
  tinfo2 = as.matrix(unlist(tinfo))
  rownames(tinfo2) = c("Minimum Score","Maximum Score", "Mean Score","Median Score",
                       "Standard Deviation","IQR", "Skewness (G1)",
                       "Kurtosis (G2)")
  colnames(tinfo2) = "Value" 
  
  tinfo2
  
}

#' @export
summary.QMEtest = function(QMEtest, ...) {
  test_summary_matrix(test_summary_list(QMEtest))

}

#' @export

plot.QMEtest = function(QMEtest, ...) {
  
  ## Extracts scores from oz
  scores = data.frame(scores = getTotalScores(QMEtest))
  
  ## If >= 50 examinees, distribution of scores presented with a histogram.  If less than 50,
  ## a dotplot is produced
  if(nrow(scores) >= 50) {
    
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
  print(scoreplot)

	
}