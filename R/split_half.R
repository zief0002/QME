split_half <- function(x, oddEven = TRUE, ...){

# Split test by even and odd items if oddEven = TRUE (default)
# If oddEven = FALSE then the test is split randomly

	if(oddEven == 1){
		even.items = x[ , 1:length(x)%%2 == 0]
		odd.items = x[ , 1:length(x)%%2 == 1]
		even.score = rowSums(even.items)
		odd.score = rowSums(odd.items)
		r = cor(even.score, odd.score)
		} else{ 
			samp.items = sample(1:length(x), length(x)/2, replace = FALSE)
			form.a = x[ , samp.items]
			form.b = x[ , -samp.items]
			form.a.score = rowSums(form.a)
			form.b.score = rowSums(form.b)
			r = cor(form.a.score, form.b.score)
		}	

	# Correct the correlation
	SBr = (2 * r) / (r + 1)

	# Format output
	nice.output = data.frame(Estimate = c(r, SBr), row.names = c("r", "SBr"))
	return(nice.output)

}

#split_half(LSAT)
#split_half(LSAT, oddEven = FALSE)