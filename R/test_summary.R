# This function computes total scores for the respondents and then computes summary measures

test_summary = function(test, key, id = TRUE, d = 2, plot = FALSE, ...){

	column_start = ifelse(id == TRUE, 2, 1)

	# If a key is included, call the right_wrong() function
	if(!missing(key)){
		rw = right_wrong(test, key = key, id = id)

		keyed_test = rw$keyed_test
		key = rw$key
		raw_test = rw$raw_test

	} else {
		# If the data are not numeric and there is no key, output an error message
		if(is.numeric(test[ , column_start]) == FALSE){
		return(cat("Your data have not been keyed. Please input an answer key using the key= argument. Have a nice day."))
		} else{
			raw_test = NULL
			key = NULL
			keyed_test = test	
		}	
	}

	

	# Get the total scores for each student (row)
	scores = apply(keyed_test[column_start:length(keyed_test)], MARGIN = 1, sum, na.rm = TRUE)
	
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
	props$proportion = round(props$frequency / nrow(keyed_test), d)

	props = props[ , c("score", "proportion")]


	# Compute summary measure for total scores
	summary_scores = list(
		number_items = length(keyed_test[ , column_start:length(keyed_test)]),
		number_examinees = nrow(keyed_test),
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
		proportion_score = props,
		raw_test = raw_test,
		key = key,
		keyed_test = keyed_test,
		keyed_test_no_id = keyed_test[column_start:length(keyed_test)]
		)
	
	# If plot=TRUE then output histogram of total scores
	if(plot == TRUE){
		s = data.frame(scores = scores)
		p1 = ggplot(data = s, aes(x = scores)) +
			geom_histogram(fill = "steelblue", color = "black") +
			theme_bw() +
			xlab("Total Score") +
			ylab("Frequency")
		summary_scores = c(summary_scores, plot_score = list(p1))
		}
	

	return(summary_scores)
	
}

#whee <- test_summary(math, key = mathKey, plot = TRUE)
# To plot: whee$plot_score