# This will print the test-level output
# The print function for class 'oz' is just pretty_output, basically.

print.oz = function(x, ...) {
  pretty_output(x, ...)
}

pretty_output = function(x, ...){
	oz2 = matrix(c(
		x$test_level$descriptives$number_items, 
		x$test_level$descriptives$number_examinees,
		x$test_level$descriptives$min_score,
		x$test_level$descriptives$max_score,
		x$test_level$descriptives$mean_score,
		x$test_level$descriptives$median_score,
		x$test_level$descriptives$sd_score,
		x$test_level$descriptives$iqr_score,
		x$test_level$descriptives$skew_score,
		x$test_level$descriptives$kurtosis_score
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


