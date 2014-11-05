# This function computes total scores for the respondents and then computes summary measures

test_summary = function(test, key, id = TRUE, d = 2, plot = FALSE, ...){
  QMEtest1 = QMEtest(test, key = key, id = id)
  if(plot)
    print(plot(QMEtest1))
  
  return(QMEtest1)
}

summary.QMEtest = function(QMEtest, d = 2, ...) {

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
	props$proportion = round(props$frequency / length(scores), d)

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

plot.QMEtest = function(QMEtest, ...) {
  
  scores = getTotalScores(QMEtest)

	# Returns ggplot2 histogram of total scores
		s = data.frame(scores = scores)
		p1 = ggplot(data = s, aes(x = scores)) +
			geom_histogram(fill = "steelblue", color = "black") +
			theme_bw() +
			xlab("Total Score") +
			ylab("Frequency")
	
  return(p1)
	
}

#whee <- test_summary(math, key = mathKey, plot = TRUE)
# To plot: whee$plot_score