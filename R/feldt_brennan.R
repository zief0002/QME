##############################################################
## Function to produce the Feldt-Gilmer reliability from test data
##############################################################

feldt_brennan = function(x, ...){
  
	# create covariance matrix of the data frame
	cov_matrix = cov(x, use = "pairwise.complete.obs")
  
	# Get the variance for the scores
	score_var = sum(cov.matrix)

	# Get the item variances
	item_var = sum(diag(cov.matrix))

	# Compute sum of the squared row sums
	sq_row_sums = sum(rowSums(cov.matrix) ^ 2)

	fb = (tot_var * (tot_var - obs_var)) / ((tot_var ^ 2 - sq_row_sums))

	# Compute CI based on Feldt's (1965) method
	k = nrow(cov.matrix)
	n = nrow(x)

	df_1 = n - 1
	df_2 = (n - 1) * (k - 1)

	lower_limit = 1 - ((1 - fb) * qf(0.975, df_1, df_2))
	upper_limit = 1 - ((1 - fb) * qf(0.0255, df_1, df_2))

	# Compute standard error measurement
	sem = sqrt(tot_var * (1 - fb))

	return(list(fb = fb, ll = lower_limit, ul = upper_limit, sem = sem))
}

# library(QME)
# data(math)
# data(math_key)
# out = QMEtest(math, math_key)
# x = getKeyedTestNoID(out)
# feldt_brennan(x)

