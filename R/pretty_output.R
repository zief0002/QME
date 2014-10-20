# This will print the test-level output

pretty_output = function(x, ...){
	oz2 = matrix(c(
		x$test_level$number_items, 
		x$test_level$number_examinees,
		x$test_level$min_score,
		x$test_level$max_score,
		x$test_level$mean_score,
		x$test_level$median_score,
		x$test_level$sd_score,
		x$test_level$iqr_score,
		x$test_level$skew_score,
		x$test_level$kurtosis_score
		))
	rownames(oz2) = c("Number of Items:", "Number of Examinees:", "Minimum Score:", 
		"Maximum Score:", "Mean Score:", "Median Score:", "Standard Deviation:", "IQR:",
		"Skewness (G1):", "Kurtosis (G2):")
	colnames(oz2) = ""

	# Print the output to the screen
	
	cat("-------------------------------")
	print(oz2, digits = 2, print.gap = 1L)
	cat("-------------------------------")
	
}


# oz = odin_zeus(math, key = mathKey, group = NULL, focal_name = NULL)
# pretty_output(oz)


