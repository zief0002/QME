guttman_l2 = function(x, ...){
  
  # create covariance matrix of the data frame
  cov.matrix = cov(x, use = "pairwise.complete.obs")
  
  tot_var = sum(cov.matrix)
  obs_var = sum(diag(cov.matrix))
  err_var = sum(cov.matrix[row(cov.matrix) != col(cov.matrix)] ^ 2)
  k = nrow(cov.matrix)
  n = nrow(x)
  
  # Compute Guttman's L2
  l2 = (tot_var - obs_var + sqrt(k / (k-1) * err_var)) / tot_var
  
  # Compute CI based on Feldt's (1965) method
  df_1 = n - 1
  df_2 = (n - 1) * (k - 1)

  lower_limit = 1 - ((1 - l2) * qf(0.975, df_1, df_2))
  upper_limit = 1 - ((1 - l2) * qf(0.0255, df_1, df_2))

  sem = sqrt(tot_var * (1 - l2))

  return(list(l2 = l2, ll = lower_limit, ul = upper_limit, sem = sem))

}

# library(QME)
# data(math)
# data(math_key)
# out = QMEtest(math, math_key)
# x = getKeyedTestNoID(out)
# guttman_l2(x)

# Feldt, L. S. (1965). The approximate sampling distribution of Kuder-Richardson reliability coefficient twenty. Psychometrika, 30, 357-370.