##############################################################
## Function to produce coefficient alpha from test data
##############################################################




coef_alpha = function(x, ...){
  
  # create covariance matrix of the data frame
  cov.matrix = cov(x, use = "pairwise.complete.obs")
  
  # collect the number of rows from the covariance matrix
  k = nrow(cov.matrix)
  
  # use the coefficient alpha equation
  return( k / (k - 1) *(1 - (sum(diag(cov.matrix)) / sum(cov.matrix) )))
}

# example of 4 persons and 5 items
#trial <- data.frame(matrix(c(1,0,1,1,0,0,1,0,0,1,1,1,1,1,1,1,1,0,1,0),ncol=5))
#trial
#coef_alpha(trial)
