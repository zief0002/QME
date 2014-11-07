##############################################################
## Function to produce the Feldt-Gilmer reliability from test data
##############################################################

feldt_gilmer = function(x, ...){
  
  # create covariance matrix of the data frame
  cov_matrix = cov(x, use = "pairwise.complete.obs")
  
  # Get the variances
  variances = diag(cov_matrix)

  # Compute the row sums of the off-diagonal elements
  sum_of_row_covs = rowSums(cov_matrix) - variances
  
  # Compute the sums of the covariances and the variances
  total_cov = sum(sum_of_row_covs)
  total_var = sum(cov_matrix)

  # Which row has the highest sum of covariances?
  myRow = which.max(sum_of_row_covs)

  # Get that row
  d = cov_matrix[myRow, ]

  # Compute D, Q, and W
  D = (sum_of_row_covs - d) / (max(sum_of_row_covs) - d)
  Q = sum(D) ^ 2
  W = sum(D ^ 2)

  fg = Q / (Q - W) * total_cov/total_var

  # Compute CI based on Feldt's (1965) method
  k = nrow(cov.matrix)
  n = nrow(x)

  df_1 = n - 1
  df_2 = (n - 1) * (k - 1)

  lower_limit = 1 - ((1 - fg) * qf(0.975, df_1, df_2))
  upper_limit = 1 - ((1 - fg) * qf(0.0255, df_1, df_2))

  # Compute standard error measurement
  sem = sqrt(tot_var * (1 - fg))

  return(list(alpha = fg, ll = lower_limit, ul = upper_limit, sem = sem))
}

# library(QME)
# data(math)
# data(math_key)
# out = QMEtest(math, math_key)
# x = getKeyedTestNoID(out)
# feldt_gilmer(x)
