# This will print the test-level output
# The print function for class 'analyze' is just pretty_output, basically.

print.analyze = function(x, ...) {
  pretty_output(x, ...)
}

pretty_output = function(x, ...){
  
	added = as.matrix(c(`Number of Items` = x$number_items, 
	          `Number of Examinees` = x$number_examinees),
	          ncol = 1)
	out = rbind(added, x$test_level$descriptives)

	# Print the output to the screen
	
	cat("-------------------------------")
	print(out, digits = 2, print.gap = 1L)
	cat("-------------------------------")
	
}
